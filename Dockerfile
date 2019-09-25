# Author: Lorenzo Zoli (zoli.lorenzo1899@gmail.com)
# Maintainer: Lorenzo Zoli (zoli.lorenzo1899@gmail.com)
# Created: 20190925
# Last Update: 20190925
# Description: Dockerize [Pentaho Data Integration CE](https://community.hitachivantara.com/s/article/data-integration-kettle) version 8.3.0.0-371.
# Version: 1.1.1
FROM ubuntu:18.04
MAINTAINER Lorenzo Zoli (zoli.lorenzo1899@gmail.com)

# set environment variables
ENV PDI_VER 8.3.0.0-371
ENV PDI /opt

# install curl, unzip and openjdk-8
RUN apt-get update && \
    apt-get install -y curl && \
	apt-get install -y unzip && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Fix certificate issues, found as of 
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# download PDI from sourceforge.net version 8.3.0.0-371
# extract and remove .zip previous download
RUN curl -L https://sourceforge.net/projects/pentaho/files/Pentaho%208.3/client-tools/pdi-ce-${PDI_VER}.zip/download -o /tmp/pdi.zip && \
	unzip -q /tmp/pdi.zip -d ${PDI} && \
	rm /tmp/pdi.zip && \
	rm -rf ${PDI}/data-integration/samples && \
	rm -rf ${PDI}/data-integration/docs

# create directories and do permission to execute scripts
WORKDIR $PDI
RUN mkdir transformations && \
	mkdir jobs && \
	chmod 775 ${PDI} -R && \
	chmod +x ${PDI}/data-integration/kitchen.sh && \
	chmod +x ${PDI}/data-integration/pan.sh

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME