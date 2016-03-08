# DOCKER-VERSION 0.3.4
FROM        perl:latest
MAINTAINER  Fernando Correa de Oliveira

ADD . tws

RUN apt-get update
RUN apt-get install -y mysql-client libmysqlclient-dev nodejs npm

RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install browserify -g

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Carton
WORKDIR tws
#RUN carton exec dbic-migration -S 'TWS::Schema' -Ilib --database MySQL install

RUN git clone https://github.com/FCO/Mojolicious-Plugin-CommandWS.git
RUN bash -c 'cd Mojolicious-Plugin-CommandWS && npm install && npm run postinstall'
# && carton exec cpanm . --force'
RUN carton install --deployment

#RUN browserify js/main.js -o lib/Mojolicious/Plugin/CommandWS/public/CommandWS.js

EXPOSE 8080

ENV MOJO_LOG_LEVEL debug
ENV DBIC_TRACE 1

CMD carton exec perl -IMojolicious-Plugin-CommandWS/lib script/tws prefork
#CMD carton exec perl -IMojolicious-Plugin-CommandWS/lib /root/tws/local/bin/hypnotoad script/tws
