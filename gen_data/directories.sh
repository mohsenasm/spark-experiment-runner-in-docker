#!/bin/sh

## Copyright 2015-2017 Eugenio Gianniti <eugenio.gianniti@polimi.it>
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

[ "x$(whoami)" = "xhdfs" ] || [ "x$(whoami)" = "xroot" ] || exec sudo -u hdfs sh "$0"

hadoop fs -mkdir /tmp/tpcds-generate
hadoop fs -chmod 777 /tmp/tpcds-generate
hadoop fs -chown ubuntu:hdfs /tmp/tpcds-generate

hadoop fs -mkdir /user/ubuntu
hadoop fs -chmod 755 /user/ubuntu
hadoop fs -chown ubuntu:hdfs /user/ubuntu
