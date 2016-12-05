echo "STARTING DELETING /user/ubuntu"
hdfs -dfs -rm -r -skipTrash /user/ubuntu
echo "STARTING DELETING /tmp/ubuntu"
hdfs -dfs -rm -r -skiptTrash /tmp/ubuntu
