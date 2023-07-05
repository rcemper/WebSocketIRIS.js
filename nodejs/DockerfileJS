ARG IMAGE=ubuntu:18.04
FROM $IMAGE
USER root

WORKDIR /opt/node

RUN apt-get update && \
    apt-get install -y \
    npm \
    nodejs 
