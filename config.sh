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

# Jobs to run
JOBS='query26 query55'

# Repetitions
REPETITIONS=1

# Scale of TPCDS generated data (in Gigabytes)
SCALE=2

# Database name
DB_NAME=tpcds_text_$SCALE

# PySpark executable
PYSPARK=pyspark

# SparkSubmit options
# Example:
#   --master yarn --num-executors 3 --executor-memory 1g --driver-memory 1g
#   --executor-cores 4 --deploy-mode client
# All this options must be put in a single string
SPARK_OPTS='--master yarn'

# Use Spark REST API
REST_API=yes

# Spark History server IP
HISTORY_SERVER_IP=localhost

# Spark logs directory on HDFS
SPARK_LOGS=

# Regex for fetching the ID of a Spark application
FETCH_REGEX='application_([0-9]+)_([0-9]+)'

# Waiting time before downloading logs
WAIT_LOG=20s
