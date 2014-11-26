#
# Base Ubuntu image for Barchart applications.
#

FROM ubuntu:trusty
MAINTAINER Jeremy Jongsma "jeremy@barchart.com"

ENV DEBIAN_FRONTEND noninteractive

# Update base packages
RUN apt-get --yes update
RUN apt-get --yes dist-upgrade
RUN apt-get --yes install wget tar unzip git supervisor python python-pip python-setuptools software-properties-common

# Runtime decryption services - see https://github.com/barchart/crypter
# This will only be mapped for trusted containers
VOLUME ["/var/run/crypter"]
ADD etc/crypter /etc/
RUN pip install crypter boto

# Logging volume for export to log aggregator by host
VOLUME ["/var/log/ext"]
