FROM debian:jessie

MAINTAINER Petr Messner, petr.messner@gmail.com

# prevent apt warnings about unusable dialog frontend
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# prevent warning "delaying package configuration, since apt-utils is not installed"
RUN apt-get -y install apt-utils

# https transport is needed for that deb.nodesource.com
RUN apt-get -y install apt-transport-https curl

RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list
RUN echo "deb https://deb.nodesource.com/node_4.x jessie main" >> /etc/apt/sources.list

RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install build-essential vim git python2.7
RUN apt-get -y install nodejs
RUN npm install -g npm@3.x
RUN npm install -g gulp-cli
RUN npm install -g node-gyp

RUN git clone https://github.com/este/este.git
WORKDIR este

RUN npm install --unsafe-perm
# "--unsafe--perms" are needed because commands run under root in Docker
# (https://github.com/este/este/issues/445#issuecomment-147231625)

RUN npm run web-build

EXPOSE 8000

CMD ["npm", "run", "web-start"]
