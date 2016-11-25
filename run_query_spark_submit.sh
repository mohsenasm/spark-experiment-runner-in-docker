QUERYID=$1
SPARK_SUBMIT_PATH=$2
MASTER="yarn-master"
N_EXECUTORS=1
MEMORY_EXECUTOR="512m"
DRIVER_MEM="512m"


if [ -f ./tmp.py ]; then
    rm tmp.py
fi
touch tmp.py
cat ./queryPreamble.py >> tmp.py
cat ./queries/query$QUERYID.py >> tmp.py
spark-submit --master ${MASTER} --executor-memory ${MEMORY_EXECUTOR} --driver-memory ${DRIVER_MEM} --num-executors ${N_EXECUTORS} tmp.py
