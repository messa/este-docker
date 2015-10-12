este-docker
===========

[![Join the chat at https://gitter.im/messa/este-docker](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/messa/este-docker?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This repository contains Dockerfile that creates Docker image with node, npm and este.

Why?
----

Just for fun. I had some problems running the node stack on my dev machine (fresh versions of node and npm needed etc.), so I decided to do it in Docker, because Docker provides clean and deterministic environment (kind of like git for whole operating system).

This Dockerfile is good only for Este demo (without the hassle of installing all the node modules). But it can also serve as inspiration for your own web apps.

Usage
----

Install [Docker](https://www.docker.com/)

Download and run Docker [image](https://hub.docker.com/r/messa/este/):

    docker pull messa/este
    docker run --rm -p 8000:8000  messa/este

Now open http://127.0.0.1:8000 and you should see Este demo. Add some todos! :)

Alternatively, instead of `docker pull` you can build your own image:

    git clone https://github.com/messa/este-docker.git
    cd este-docker
    docker build --tag my-este .


Notes
-----

I've used base image `debian:jessie`. Maybe official `node` image would be better, but at least it is demonstrated how to prepare node environment on Debian.

Maybe the Docker image for Este development (so the source code is accessed via Docker volume) would be more useful.
