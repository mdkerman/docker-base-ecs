#
# Base Ubuntu image for Barchart applications.
#
# All container processes are launched via supervisord. To run a process in this container,
# child containers must provide supervisor job configurations in /etc/supervisor/conf.d.
#

FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

# Update base packages
RUN apt-get update
RUN apt-get --yes dist-upgrade
RUN apt-get --yes install wget tar unzip git supervisor python python-pip python-setuptools python-software-properties

# Socket directory for runtime decryption services - see https://github.com/barchart/crypter
# This will only be mapped for trusted containers
VOLUME ['/var/run/crypter']

# Always starts supervisor
ENTRYPOINT ['/usr/bin/supervisord', '-n']