source ./config.sh

if [ $# -eq 0 ]
then
  echo "Error: usage is [APP_ID]"
  exit -1;
fi
for appId in "$@"; do
    endpoint="${HISTORY_SERVER_IP}/api/v1/applications/${appId}/logs"
    outfile="./logs/eventLogs-${appId}.zip"
    curl -# "$endpoint" -o "$outfile"
done
