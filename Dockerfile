FROM debian:jessie

MAINTAINER Petr Messner, petr.messner@gmail.com

# prevent apt warnings about unusable dialog frontend
ENV DEBIAN_FRONTEND noninteractive

# prevent warning "delaying package configuration, since apt-utils is not installed"
# https transport is needed for that deb.nodesource.com
RUN apt-get update && \
    apt-get -y install --no-install-recommends \
        apt-transport-https \
        apt-utils \
        ca-certificates \
        curl && \
    apt-get clean

RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list && \
    echo "deb https://deb.nodesource.com/node_4.x jessie main" >> /etc/apt/sources.list && \
    curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install --no-install-recommends \
        build-essential \
        git \
        nodejs \
        python \
        python2.7 \
        vim && \
    apt-get clean

RUN npm install -g npm@3.x
RUN npm install -g \
    gulp-cli \
    node-gyp

RUN git clone https://github.com/este/este.git
WORKDIR este

RUN npm install --unsafe-perm
# "--unsafe--perm" are needed because commands run under root in Docker
# (https://github.com/este/este/issues/445#issuecomment-147231625)

RUN NODE_ENV=production gulp build

ADD signal_wrapper.py /

EXPOSE 8000

CMD ["/signal_wrapper.py", "env", "NODE_ENV=production", "node", "src/server"]
