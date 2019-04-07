# mysql-buckup
Automatic/periodic cron backup MySQL DB to FTP server by lightweight docker image with simple settings 🌂

## Description
This image making automatic backup from any mysql host to ftp server by mysqldump and curl utils.

## Usage
You can use mysql-backup by docker-compose:
```
version: '2'

services:
    mysql-backup:
        image: vmpartner/mysql-buckup
        links:
            - mysql:mysql
        depends_on:
            - mysql
        environment:
            MYSQL_HOST: mysql
            MYSQL_USER: my_db_user
            MYSQL_PASSWORD: my_db_password
            MYSQL_DATABASE: my_db_name
            FTP_USER: my_ftp_user
            FTP_PASSWORD: my_ftp_password
            FTP_URL: "ftp://ftp.selcdn.ru/backup/"
            CRON_JOB: "0 */6 * * *"
        restart: unless-stopped
```

or by docker run:
```
docker run \
    -dit \
    --restart unless-stopped \
    --name mysql-buckup \
    --link mysql:mysql \
    -e MYSQL_HOST=mysql \
    -e MYSQL_USER=my_db_user \
    -e MYSQL_PASSWORD=my_db_password \
    -e MYSQL_DATABASE=my_db_name \
    -e FTP_USER=my_ftp_user \
    -e FTP_PASSWORD=my_ftp_password \
    -e FTP_URL="ftp://ftp.selcdn.ru/backup/" \
    -e CRON_JOB="0 */6 * * *" \
    vmpartner/mysql-buckup
```

You need set MYSQL, FTP details and periodic task CRON_JOB in cron format. If you don't know cron, please read more at https://en.wikipedia.org/wiki/Cron

## Note ⚠
Note that "restart: unless-stopped" required, because first time container run trick for generating cron file by your CRON_JOB, that set by your env variable and then will kill main process for restart. Please see file bin/add_task for details.
