QUERYID=$1
touch tmp.py
cat ./queryPreamble.py >> tmp.py
cat ./queries/query$QUERYID.py >> tmp.py
