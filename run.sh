#! /bin/sh

set -e

if [ "$RCLONE_DEST" = "**None**" ]; then
  echo "Please set RCLONE_DEST"
  return 1
fi

if [ "$SCHEDULE" = "**None**" ]; then
  echo "Please set SCHEDULE"
  return 1
fi

if [ "$MYSQL_HOST" = "**None**" ]; then
  echo "Please set MYSQL_HOST"
  return 1
fi

if [ "$MYSQL_USER" = "**None**" ]; then
  echo "Please set MYSQL_USER"
  return 1
fi

if [ "$MYSQL_DATABASE" = "**None**" ]; then
  echo "Please set MYSQL_DATABASE"
  return 1
fi

echo "$SCHEDULE /backup.sh" > /crontab.txt
/usr/bin/crontab /crontab.txt
exec /usr/sbin/crond -f -l 8
