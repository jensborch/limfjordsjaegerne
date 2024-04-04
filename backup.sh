!/bin/bash

HOST='ftp.limfjordsjaegerne.dk'
USER='limfjordsjaegerne.dk'
PASSWD='xxxxx'
BACKUP_DIR=/backup/Limfjordsjaegerne

mkdir -p $BACKUP_DIR
echo "Deleting old backups"
find ${BACKUP_DIR}/backup-* -mtime +30 -exec rm {} \;
rm -rf ${BACKUP_DIR}/temp
mkdir -p ${BACKUP_DIR}/temp
echo "Getting data"
lftp -e "mirror . ${BACKUP_DIR}/temp; bye" -u $USER,$PASSWD $HOST
tar -pczf ${BACKUP_DIR}/backup-"$(date +%FT%H%M%S)".tar -C ${BACKUP_DIR}/temp .
