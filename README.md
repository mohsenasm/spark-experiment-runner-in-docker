# TPCDS
This repo supposes you have hadoop, spark, hive, hdfs and yarn correctly installed
and configured

1. Generate the TCPDS benchmark data using ```setup.sh``` in the ```gen_data``` folder
2. Edit the scale parameter in ```queryPreamble.py``` according to the scale of the tpcds
data
3. Run a specific query by using ```run_query_spark_shell.sh [insert here query number]```
or ```run_query_spark_submit.sh [insert here query number]```.
4. Run all queries by using ```run_query_spark_shell.sh -A``` or ```run_query_spark_submit.sh -A```
5. Note that the file mentioned above contain configuration information to be edited
