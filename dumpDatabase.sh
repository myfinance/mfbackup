DUMP_FILE_NAME="backupOn`date +%Y-%m-%d-%H-%M`.psql.gz"
echo "Creating dump: $DUMP_FILE_NAME"

cd /var/dumps

#pg_dump -C -w --format=c --blobs > $DUMP_FILE_NAME
#pg_dump -c --if-exists -d marketdata -h postgres_mf -p 5432 -U postgres | gzip > /var/dumps/$DUMP_FILE_NAME
pg_dump -c --if-exists | gzip > /var/dumps/$DUMP_FILE_NAME

if [ $? -ne 0 ]; then
  rm $DUMP_FILE_NAME
  echo "Back up not created, check db connection settings"
  exit 1
fi

echo 'Successfully Backed Up'
exit 0