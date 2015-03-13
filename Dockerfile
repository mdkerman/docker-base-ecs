#
# Base Ubuntu image for Barchart applications.
#
# docker-build properties:
# TAG=barchart/base:latest

FROM ubuntu:trusty
MAINTAINER Jeremy Jongsma "jeremy@barchart.com"

ENV DEBIAN_FRONTEND noninteractive

# Update base packages
RUN apt-get --yes update && \
	apt-get --yes install wget tar unzip git python python-pip python-setuptools software-properties-common && \
	apt-get clean && \
	pip install crypter boto awscli

ADD root/ /root/

# Runtime decryption services - see https://github.com/barchart/crypter
# This will only be mapped for trusted containers
VOLUME ["/var/run/crypter"]
ADD etc/crypter /etc/

# Logging volume for export to log aggregator by host
VOLUME ["/var/log/ext"]
