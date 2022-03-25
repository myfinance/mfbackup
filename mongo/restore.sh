#!/bin/bash

echo ******************************************************
echo Starting-RESTORE
echo ******************************************************


mongorestore --uri=$MONGODB_URI  --username=$MONGODB_USER --password=$MONGODB_PASSWORD --authenticationDatabase=admin --gzip --archive=/mongodump/$FILE


sleep 30 | echo End-BACKUP