# DOCKER-VERSION 0.3.4
FROM        perl:latest
MAINTAINER  Fernando Correa de Oliveira

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Carton Mojolicious

EXPOSE 3000

WORKDIR tws
CMD carton exec scripts/tws daemon
