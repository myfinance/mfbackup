#!/bin/bash

echo ******************************************************
echo Starting-BACKUP
echo ******************************************************
NOW="$(date +"%F")-$(date +"%T")"

FILE="$DB_NAME-$NOW"

mongodump --uri=$MONGODB_URI  --gzip --archive=/mongodump/$FILE --username=$MONGODB_USER --password=$MONGODB_PASSWORD --authenticationDatabase=admin

sleep 30 | echo End-BACKUP