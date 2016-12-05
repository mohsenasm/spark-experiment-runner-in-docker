#!/bin/sh

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
EXECUTOR_CORES=2
DRIVER_MEM="1024m"
#Available queries id + -A to indicate that all queries must be executed
ALLOWEDIDS=(19 20 21 26 40 52 55 "-A")
#Spark History server ip
HISTORY_SERVER_IP="localhost"
#Waiting for download log
WAIT_LOG="20s"
