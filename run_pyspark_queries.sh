#!/bin/sh

## Copyright 2017 Eugenio Gianniti <eugenio.gianniti@polimi.it>
## Copyright 2016 Giorgio Pea <giorgio.pea@mail.polimi.it>
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

SOURCE="$0"
while [ -L "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [ "${SOURCE%${SOURCE#?}}" != / ] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

. "$DIR"/config.sh

## Execute a job with the given name
execute ()
{
    job="$1"
    sqlfile="$DIR/queries/${job}.sql"
    failures=0

    if [ -r "$sqlfile" ]; then
        stdout_dir="$job/spark_stdout"
        stderr_dir="$job/spark_stderr"
        logs_dir="$job/logs"

        mkdir -p "$stdout_dir"
        mkdir -p "$stderr_dir"
        mkdir -p "$logs_dir"

        tempfile="${job}_tmp.py"
        trap "rm -f \'$tempfile\'; exit -1" INT TERM

        sed -e "s#@@JOB@@#$job#g" -e "s#@@DB@@#$DB_NAME#g" \
            < "$DIR"/preamble.py > "$tempfile"
        echo 'sqlContext.sql("""' >> "$tempfile"
        cat "$sqlfile" >> "$tempfile"
        echo '""").show()' >> "$tempfile"

        "$PYSPARK" $SPARK_OPTS "$tempfile" > tmp_output.txt 2> tmp_stderr.txt
        app_id="$(grep -m 1 -o -P "$FETCH_REGEX" tmp_stderr.txt)"

        if [ "x$app_id" = x ]; then
            failures=$(( $failures + 1 ))
            app_id="failed_job_$failures"
        fi

        mv tmp_output.txt "${stdout_dir}/${app_id}.txt"
        mv tmp_stderr.txt "${stderr_dir}/${app_id}.txt"
        rm "$tempfile"

        echo Execution finished
        echo Application ID: $app_id

        sleep $WAIT_LOG
        echo Downloading logs
        if [ "x$REST_API" = xyes ]; then
            "$DIR"/log_download.sh -s "$HISTORY_SERVER" \
                  -o "${logs_dir}/eventLogs-$app_id".zip "$app_id"
        else
            hadoop fs -copyToLocal "${SPARK_LOGS}/$app_id" "$logs_dir"
        fi
    else
        echo warning: you are trying to execute \'$job\', but \'$sqlfile\' \
             does not exist! >&2
    fi
}

if [ $# -gt 0 ]; then
    echo warning: no argument expected, they will be ignored >&2
fi

for it in $(seq $REPETITIONS); do
    echo Iteration $it
    for job in $JOBS; do
        echo Executing $job
        execute "$job"
    done
done
