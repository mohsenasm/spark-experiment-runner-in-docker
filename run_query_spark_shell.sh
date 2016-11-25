QUERYID=$1
if [ -f ./tmp.py ]; then
    rm tmp.py
fi
touch tmp.py
cat ./queryPreamble.py >> tmp.py
cat ./queries/query${QUERYID}.py >> tmp.py
pyspark tmp.py
