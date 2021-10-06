FROM alpine

ENV MYSQL_HOST **None**
ENV MYSQL_USER **None**
ENV MYSQL_DATABASE **None**
ENV RCLONE_DEST **None**
ENV SCHEDULE **None**
ENV CHECK_URL **None**

RUN apk update && apk add --no-cache mysql-client curl
RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cd rclone-*-linux-amd64 && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone

ADD backup.sh /backup.sh
ADD run.sh /run.sh
RUN chmod +x /backup.sh && chmod +x /run.sh && chown root:root /usr/bin/rclone && chmod 755 /usr/bin/rclone
RUN chown root:root /usr/bin/rclone && chmod 755 /usr/bin/rclone

USER root

CMD ["sh", "run.sh"]
