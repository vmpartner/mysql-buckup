#!/bin/sh

set -e

DATETIME=$(date +"%s_%Y-%m-%d")
NAME="${DATETIME}.gz"

echo "Start dump ${$NAME}"
/usr/bin/mysqldump --single-transaction --quick --lock-tables=false -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} | gzip > "/backup/${NAME}"

echo "Start copy"
rclone copy "/backup/${NAME}" "$RCLONE_DEST"
rm -rf "/backup/${NAME}"

echo "Curl check url"
if [ "$CHECK_URL" = "**None**" ]; then
  echo "INFO: Define CHECK_URL with https://healthchecks.io to monitor sync job"
else
  curl "$CHECK_URL"
fi

echo "Done"