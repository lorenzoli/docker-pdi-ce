FROM ubuntu:18.04

# set pdi default folder
ENV PDI /opt/app

# create main directories
RUN mkdir /opt/transformations \
	&& mkdir /opt/jobs

# This is in accordance to : https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get update && \
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

# install curl
# RUN apt-get update \
#     && apt-get install -y curl \
#     && apt-get -y autoclean \
#     && rm -rf /var/lib/apt/lists/*

# # download PDI from sourceforge.net : https://sourceforge.net/projects/pentaho/files/Pentaho%208.3/client-tools/pdi-ce-8.3.0.0-371.zip/download
# WORKDIR $PDI
# RUN curl -L https://sourceforge.net/projects/pentaho/files/Pentaho%208.3/client-tools/pdi-ce-8.3.0.0-371.zip/download > pdi.zip \
# 	&&

# copy app on image
# do permission to execute scripts
WORKDIR $PDI
COPY App .
RUN chmod 775 $PDI -R \
	&& chmod +x $PDI/kitchen.sh \
	&& chmod +x $PDI/pan.sh

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME