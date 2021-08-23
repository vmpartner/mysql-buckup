# Cron MySQL backup 
Automatic cron backup MySQL DB to remote server by RCLONE with simple settings 🌂

## Description
This image making automatic backup from any mysql host to any server that support RCLONE util.

## Usage
You can use mysql-backup by docker-compose:
```
version: '2'

services:
    mysql-backup:
        image: vmpartner/mysql-buckup:v2
        links:
            - mysql:mysql
        depends_on:
            - mysql
        environment:
            MYSQL_HOST: mysql
            MYSQL_USER: my_db_user
            MYSQL_PASSWORD: my_db_password
            MYSQL_DATABASE: my_db_name
            SCHEDULE: "0 */6 * * *"
            RCLONE_CONFIG_SELECTEL_TYPE: "swift"
            RCLONE_CONFIG_SELECTEL_ENV_AUTH: "false"
            RCLONE_CONFIG_SELECTEL_USER: "my_user"
            RCLONE_CONFIG_SELECTEL_KEY: "my_password"
            RCLONE_CONFIG_SELECTEL_AUTH: "https://auth.selcdn.ru/v1.0"
            RCLONE_CONFIG_SELECTEL_ENDPOINT_TYPE: "public"
            RCLONE_DEST: "selectel:my_container/my_math"
            CHECK_URL: "https://hc-ping.com/my_check_token" # Example https://healthchecks.io
        restart: unless-stopped
```
Used https://rclone.org/ for rsync to cloud

You need set MYSQL, RCLONE details and periodic task SCHEDULE in cron format. If you don't know cron, please read more at https://en.wikipedia.org/wiki/Cron