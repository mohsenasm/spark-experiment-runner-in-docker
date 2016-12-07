if [ $# -ne 1 ]
then
  echo "Error: usage is [TPCDS_DATASET_SCALE]"
  exit -1;
fi
echo "STARTING DELETING /tmp/tpcds-generate/"$1
hdfs dfs -rm  -R -skipTrash /tmp/tpcds-generate/$1
