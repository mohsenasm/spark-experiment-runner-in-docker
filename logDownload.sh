source ./config
echo ${HISTORY_SERVER_IP}
echo $1
curl ${HISTORY_SERVER_IP}/applications/$1/logs --output ./logs/log_$1.zip
