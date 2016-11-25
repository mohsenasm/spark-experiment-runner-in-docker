SPARK_HOME="/usr/hdp/current/spark-client"
ALLOWEDIDS=(19 20 21 26 40 52 55 "-A")
LENGTH=${#ALLOWEDIDS[@]}
ALL_QUERIES=0
QUERYID=$1
MASTER="yarn-master"
N_EXECUTORS=1
MEMORY_EXECUTOR="512m"
DRIVER_MEM="512m"

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
  fi
}
function executeQuery {
  if [ -f ./tmp.py ]
  then
      rm tmp.py
  fi
  touch tmp.py
  cat ./queryPreamble.py >> tmp.py
  cat ./queries/query$1.py >> tmp.py
  ${SPARK_HOME}/bin/spark-submit --master ${MASTER} --executor-memory ${MEMORY_EXECUTOR} --driver-memory ${DRIVER_MEM} --num-executors ${N_EXECUTORS} tmp.py
}
#Entry Point
if [ "$#" -gt 1 ]
then
  echo "Warning: only one argument is supported, the others will be ignored"
fi
checkargs $1
if [ $ALL_QUERIES -eq 1 ]
then
  for i in $(seq 0 $(expr $LENGTH - 2))
  do
    executeQuery ${ALLOWEDIDS[$i]}
  done
else
  executeQuery $1
fi
