# TPCDS
[![Code Climate](https://codeclimate.com/github/DeadManPoe/TPCDS/badges/gpa.svg)](https://codeclimate.com/github/DeadManPoe/TPCDS)

This repo supposes you have Hadoop, Spark, Hive, Hdfs and Yarn correctly installed
and configured. This repo is tested only with Python 2.7. Most of the shell scripts
in this repo require bash.

1. Edit the ```config.sh``` file to set parameters for Spark Submit, PySpark, Spark Shell and TPCDS benchmark data generation
1. Generate the TCPDS benchmark data using ```setup.sh``` in the ```gen_data``` folder
2. Run a specific query K times by using ```run_pyspark_queries.sh [QUERY_ID] ?[N_OF_REPETITIONS]```(The ? symbol means optionality)
or ```run_spark_submit_queries.sh [QUERY_ID] ?[N_OF_REPETITIONS]```.
4. Run all queries by using ```run_pyspark_queries.sh -A``` or ```run_spark_submit_queries.sh -A```
5. Run a scala script K times by using ```run_scala_shell [FILE] ?[N_TIMES]```, where ```[FILE]```refers to a file that contains the script to be executed
5. The output of the each run is saved in .txt format inside the ```spark_outputs``` folder
6. The stderr of each run in saved in .txt format inside the ```spark_stderr```folder
6. The log of each run is saved in .zip format inside the ```logs``` folder
