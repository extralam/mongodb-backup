FROM ubuntu:18.04
LABEL maintainer="Alan Lam <alan@solutionforest.net> <alan@goxip.com>"

RUN apt-get update && apt-get install -my wget gnupg2
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 && \
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get update && \
    apt-get install -y cron mongodb-org-shell mongodb-org-tools && \
    echo "mongodb-org-shell hold" | dpkg --set-selections && \
    echo "mongodb-org-tools hold" | dpkg --set-selections && \
    mkdir /backup

ENV CRON_TIME="0 0 * * *"
ENV TZ=Asia/Hong_Kong
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD run.sh /run.sh

VOLUME ["/backup"]

ENTRYPOINT ["/run.sh"]
