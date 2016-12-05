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
