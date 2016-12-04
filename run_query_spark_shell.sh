source ./config.sh
LENGTH=${#ALLOWEDIDS[@]}
ALL_QUERIES=0

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
  ${PYSPARK}/bin/pyspark tmp.py
}
if [ $# -eq 0 ]
then
  echo "No arguments supplied"
  exit -1;
fi
if [ $# -gt 1 ]
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
