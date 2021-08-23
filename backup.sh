#!/bin/sh

set -e

DATETIME=$(date +"%s_%Y-%m-%d")
NAME="${DT}.gz"

/usr/bin/mysqldump --single-transaction --quick --lock-tables=false -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} | gzip > "/backup/${NAME}"
rclone copy "/backup/${NAME}" "$RCLONE_DEST"
rm -rf "/backup/${NAME}"

if [ "$CHECK_URL" = "**None**" ]; then
  echo "INFO: Define CHECK_URL with https://healthchecks.io to monitor sync job"
else
  curl "$CHECK_URL"
fi