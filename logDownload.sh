#!/bin/sh

source ./config.sh
error_aux ()
{
    echo "$0: $1: $2" >&2
    exit 1
}
alias error='error_aux $LINENO '

while getopts :s: opt; do
    case "$opt" in
        s)
            ip="$OPTARG"
            ;;
        \?)
            error "unrecognized option -$OPTARG"
            ;;
        :)
            error "-$OPTARG option requires an argument"
            ;;
    esac
done
shift $(expr $OPTIND - 1)


if [ "x$ip" = x ]; then
    error "you should provide the address of the History Server with the -s option"
fi

if echo "$ip" | grep -qv //; then
    server="http://$ip"
else
    server="$ip"
fi
ip="${ip#*//}"
if [ "x$ip" = "x${ip%:*}" ]; then
    server="${server}:18080"
fi

for appId in "$@"; do
    endpoint="${HISTORY_SERVER_IP}/api/v1/applications/${appId}/logs"
    outfile="eventLogs-${appId}.zip"
    curl -# "$endpoint" -o "$outfile"
done
