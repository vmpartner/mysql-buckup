FROM alpine

RUN apk add --no-cache mysql-client curl
RUN mkdir /backup

ADD bin/crontab /var/spool/cron/crontabs/root
ADD bin/backup /usr/local/bin/backup
ADD bin/add_task /usr/local/bin/add_task
RUN chmod +x /usr/local/bin/add_task && \
    chmod +x /usr/local/bin/backup

CMD crond -f && tail -f /var/log/cron.log