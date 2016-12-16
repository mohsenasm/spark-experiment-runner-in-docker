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
REPETITIONS_N=1
APP_ID=""

## Checks if the passed parameter is a number, if not exits the process
function isNumber {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
     echo "Error: Scale factor in config file or Repetition factor is not an integer number" >&2; exit 1
  fi
}
function concatConfs {
  CONFIGS=""
  for config in ${CONFIGURATIONS}
  do
    CONFIGS=${CONFIGS}" --conf "$config
  done
  echo ${CONFIGS}
}
function concatPackages {
  PACKAGES=""
  for package in ${SPARK_PACKAGES}
  do
    PACKAGES=${PACKAGES}" --packages "$package
  done
  echo ${PACKAGES}
}
## Checks arguments validity
function checkargs {
  if [ ! -f $1 ]
  then
    echo "Error: the provided file seems not to exist"
    exit -1
  fi
  if ! [ -z $2 ]
  then
    isNumber $2
    REPETITIONS_N=$2
  fi
}
## Executes the query
function executeQuery {
  echo $(concatConfs)
  echo $(concatPackages)


  ## Executes pyspark with stdout/stderr redirect to app_id.txt
  ${SPARK_SHELL}/spark-shell --deploy-mode ${DEPLOY} \
    --executor-memory ${MEMORY_EXECUTOR} \
    --driver-memory ${DRIVER_MEM} \
    --master ${MASTER} \
    --num-executors ${N_EXECUTORS} \
    --executor-cores ${EXECUTOR_CORES} \
    --driver-cores ${DRIVER_CORES} \
    --total-executor-cores ${TOT_EXECUTOR_CORES} \
    ${CONFIGS} \
    ${PACKAGES} \
    <$1 &> app_id.txt
  ## Grabs the spark job application id from the redirected stdout/stderr
  APP_ID=$(cat app_id.txt | grep -m 1 -Po "application_([0-9])+_([0-9])")
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
  echo "Error: usage is [FILE] ?[N_TIMES]"
  exit -1;
fi
if [ $# -gt 2 ]
then
  echo "Warning: only maximum two arguments are supported, the others will be ignored"
fi
checkargs $1 $2
for j in $(seq 1 ${REPETITIONS_N})
do
  echo "EXECUTING SCRIPT, REPETITION $j"
  executeQuery $1
done
