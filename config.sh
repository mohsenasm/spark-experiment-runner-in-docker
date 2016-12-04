#Scale of TPCDS generated data (in Gigabytes)
export SCALE=2
#PySpark path
PYSPARK="/usr/bin"
#SparkSubmit path
SPARK_HOME="/usr/hdp/current/spark-client"
#SparkSubmit opts
MASTER="yarn"
DEPLOY="client"
N_EXECUTORS=4
MEMORY_EXECUTOR="1024m"
DRIVER_MEM="1024m"
#Available queries id + -A to indicate that all queries must be executed
ALLOWEDIDS=(19 20 21 26 40 52 55 "-A")
