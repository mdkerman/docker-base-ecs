#
# Base Ubuntu image for Barchart applications on AWS ECS.
#
# docker-build properties:
# TAG=barchart/base-ecs:latest

FROM ubuntu:trusty
MAINTAINER Mark Kerman "mark.kerman@barchart.com"

ENV DEBIAN_FRONTEND noninteractive

# Update base packages
RUN apt-get --yes update && \
	apt-get --yes install wget tar unzip git python python-setuptools software-properties-common && \
	apt-get clean && \
	wget https://bootstrap.pypa.io/get-pip.py && \
	sudo python get-pip.py && \
	pip install boto awscli

ADD root/ /root/

# Logging volume for export to log aggregator by host
VOLUME ["/var/log/ext"]
