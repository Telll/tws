# DOCKER-VERSION 0.3.4
FROM        perl:latest
MAINTAINER  Fernando Correa de Oliveira

ADD . tws

RUN apt-get update
RUN apt-get install -y mysql-client libmysqlclient-dev

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Carton
WORKDIR tws
RUN ls -la
RUN carton install --deployment

EXPOSE 3000

CMD carton exec script/tws daemon
