#!/bin/bash

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

source ./config.sh
LENGTH=${#ALLOWEDIDS[@]}
ALL_QUERIES=0
REPETITIONS_N=1
APP_ID=""

## Checks if the passed parameter is a number, if not exits the process
function isNumber {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
     echo "Error: Scale factor in config file or Repetition factor is not an integer number" >&2; exit 1
  fi
}
## Checks if the passed parameter exists in ALLOWEDIDS, sets some variables
## To perform the execution of all queries or of a sigle query multiple time
function checkargs {
  RESULT=0
  for i in "${ALLOWEDIDS[@]}"
  do
    if [ $i = $1 ]
    then
      RESULT=1
    fi
  done
  if [ $RESULT -eq 0 ]
  then
    echo "The inserted query id does not match with any existing one"
    exit -1;
  fi
  if [ $1 = "-A" ]
  then
    ALL_QUERIES=1
  else
    if ! [ -z $2 ]
    then
      isNumber $2
      REPETITIONS_N=$2
    fi
  fi
}
## Executes a query with the given id
function executeQuery {
  if [ -f ./tmp.py ]
  then
      rm tmp.py
  fi
  touch tmp.py
  ## Generates a file that puts together the query preamble + the query body
  cat ./queryPreamble.py >> tmp.py
  cat ./queries/query$1.py >> tmp.py
  ## Executes spark-submit with stdout/stderr redirect to app_id.txt
  ${SPARK_HOME}/bin/spark-submit --master ${MASTER} --deploy-mode ${DEPLOY} --executor-memory ${MEMORY_EXECUTOR} --driver-memory ${DRIVER_MEM} --num-executors ${N_EXECUTORS} --executor-cores ${EXECUTOR_CORES} tmp.py &> app_id.txt
  ## Grabs the spark job application id from the redirected stdout/stderr
  APP_ID=$(cat app_id.txt | grep -m 1 -Po "application_([0-9]+)_([0-9]+)")
  mv app_id.txt spark_outputs/${APP_ID}.txt
  echo "EXECUTION FINISHED"
  echo "APP ID: ${APP_ID}"
  sleep ${WAIT_LOG}
  echo "DOWNLOADING LOGS"
  ## Executes log dowload
  ./logDownload.sh -s ${HISTORY_SERVER_IP} ${APP_ID}
  echo "DOWNLOAD COMPLETED"
}
## Entry Point
## Correct usage check
if [ $# -eq 0 ]
then
  echo "Error: usage is [QUERY_ID | -A FOR EXECUTE ALL] ?[N_TIMES]"
  exit -1;
fi
if [ "$#" -gt 2 ]
then
  echo "Warning: only maximum two arguments is supported, the others will be ignored"
fi
checkargs $1 $2
##
## Queries execution
if [ $ALL_QUERIES -eq 1 ]
then
  for i in $(seq 0 $(expr $LENGTH - 2))
  do
    echo "EXECUTING QUERY ${ALLOWEDIDS[$i]}"
    executeQuery ${ALLOWEDIDS[$i]}
  done
else
  for j in $(seq 1 ${REPETITIONS_N})
  do
    echo "EXECUTING QUERY $1, REPETITION $j"
    executeQuery $1
  done
fi
