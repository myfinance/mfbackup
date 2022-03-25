#!/bin/bash

echo ******************************************************
echo Starting-BACKUP
echo ******************************************************
NOW="$(date +"%F")-$(date +"%T")"

FILE="$DB_NAME-$NOW"

mongodump --uri=$MONGODB_URI  --out=/mongodump/db/$FILE

sleep 30 | echo End-BACKUP