# TPCDS
This repo supposes you have hadoop, spark, hive, hdfs and yarn correctly installed
and configured

1. Generate the TCPDS benchmark data using ```setup.sh``` in the ```gen_data``` folder
2. Edit the scale parameter in ```queryPreamble.py``` according to the scale of the tpcds
data
3. Either run one or all of the available queries using the ```run_query_spark_submit```
or ```run_query_spark_shell```. Note that some configuration information is present in those files
so check them out
