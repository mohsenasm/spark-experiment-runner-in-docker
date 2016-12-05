## Copyright 2016 Giorgio Pea <giorgio.pea@mail.polimi.it>
## From a work of Eugenio Gianniti
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

source ../config.sh
function isNumber {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
     echo "error: Scale factor in config file is not an integer number" >&2; exit 1
  fi
}
if [ $# -gt 0 ]; then
  echo "setup.sh: This script takes no arguments, therefore they will be ignored"
fi
isNumber $SCALE

SOURCE="$0"
while [ -L "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [ $SOURCE != /* ] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

"${DIR}/directories.sh"
"${DIR}/tarballs.sh"
"${DIR}/dataset.sh" "${SCALE}" /tmp/ubuntu
