# Spark Experiment Runner

All the code contained in this repo is licensed under the [Apache
License, version 2](https://www.apache.org/licenses/LICENSE-2.0).

This repo supposes you have Hadoop, Spark, Hive, HDFS and YARN correctly
installed and configured.
Most of the shell scripts in this repo are Bourne shell compliant.

1. Edit the ```config.sh``` file to set parameters for PySpark and the
   TPC-DS benchmark data generation;
1. Generate the TCP-DS benchmark data using ```setup.sh```
   in the ```gen_data``` folder;
1. Run experiments with ```run_pyspark_queries.sh```.

## Configuration

The configuration file, ```config.sh```, is thoroughly commented.

Notice that the Spark versions preceding 1.5.0 did not provide
a REST endpoint to obtain all the logs related to an application.
If your installation is recent enough, set ```REST_API=yes```
and write the HTTP address to the Spark History Server in the
```HISTORY_SERVER``` variable.
Otherwise, disable ```REST_API``` and provide the HDFS path
where the History Server stores its logs via the
```SPARK_LOGS``` variable.

## Disclaimer
This is a work-in-progress project. (WIP)
