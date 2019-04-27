FROM alpine:latest

RUN apk update 
RUN apk add bash python python-dev py-pip build-base openssl-dev libffi-dev dcron curl wget rsync ca-certificates iputils vim bind-tools openssh-client nfs-utils
RUN apk add --no-cache python3
RUN rm -rf /var/cache/apk/*
RUN mkdir -p /var/log/cron && mkdir -m 0644 -p /var/spool/cron/crontabs && touch /var/log/cron/cron.log && mkdir -m 0644 -p /etc/cron.d
RUN mkdir -p /scripts
RUN mkdir -p /tank
RUN apk add tzdata && cp /usr/share/zoneinfo/Europe/Vienna /etc/localtime && echo "Europe/Vienna" > /etc/timezone && apk del tzdata

COPY /startup/* /
RUN chmod +x /docker-entry.sh
RUN chmod +x /docker-cmd.sh

ENTRYPOINT ["/docker-entry.sh"]
CMD ["/docker-cmd.sh"]
