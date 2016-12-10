#!/bin/sh

## Copyright 2016 Giorgio Pea <giorgio.pea@mail.polimi.it>
## From a work of Eugenio Gianniti <https://github.com/eg123-gh>
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
    endpoint="${server}/api/v1/applications/${appId}/logs"
    outfile="./logs/eventLogs-${appId}.zip"
    curl -# "$endpoint" -o "$outfile"
done
