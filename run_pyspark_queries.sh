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
    [ "$SOURCE" != /* ] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

. "$DIR"/config.sh

## Execute a job with the given name
execute ()
{
    job="$1"
    sqlfile="$DIR/queries/${job}.sql"

    if [ -r "$sqlfile" ]; then
        mkdir -p spark_stdout/"$job"
        mkdir -p spark_stderr/"$job"
        mkdir -p logs/"$job"

        tempfile="${job}_tmp.py"
        trap "rm -f \'$tempfile\'; exit -1" INT TERM

        sed -e "s#@@JOB@@#$job#g" -e "s#@@DB@@#$DB_NAME#g" \
            < "$DIR"/preamble.py > "$tempfile"
        echo 'sqlContext.sql("""' >> "$tempfile"
        cat "$sqlfile" >> "$tempfile"
        echo '""").show()' >> "$tempfile"

        "$PYSPARK" $SPARK_OPTS "$tempfile" > tmp_output.txt 2> tmp_stderr.txt
        app_id="$(grep -m 1 -o -E "$FETCH_REGEX" tmp_stderr.txt)"
        mv tmp_output.txt "spark_stdout/$job/${app_id}.txt"
        mv tmp_stderr.txt "spark_stderr/$job/${app_id}.txt"
        rm "$tempfile"

        echo Execution finished
        echo Application ID: $app_id

        sleep $WAIT_LOG
        echo Downloading logs
        outfile="logs/$job/eventLogs-${app_id}"
        if [ "x$REST_API" = xyes ]; then
            "$DIR"/log_download.sh -s "$HISTORY_SERVER" \
                  -o "$outfile".zip "$app_id"
        else
            hadoop fs -copyToLocal "${SPARK_LOGS}/$app_id" "$outfile"
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
