# docker-pdi-ce
Dockerize [Pentaho Data Integration CE](https://community.hitachivantara.com/s/article/data-integration-kettle) version 8.3.0.0-371.
Docker image version 1.1.1.

# About
Pentaho Data Integration (PDI) provides the Extract, Transform, and Load (ETL) capabilities that facilitates the process of capturing, cleansing, and storing data using a uniform and consistent format that is accessible and relevant to end users and IoT technologies.

This version of docker image doesn't permits to execute PDI UI for create new transformations or jobs but allow to execute them when call **kitchen.sh** or **pan.sh**.<br>

[Here](https://help.pentaho.com/Documentation/7.0/0L0/0Y0/070) you have more documentation about kitchen and pan.

# Index
1. [Before start](https://github.com/lorenzoli/docker-pdi-ce#before-start)
2. [Clone project](https://github.com/lorenzoli/docker-pdi-ce#clone-projects)
3. [Build image](https://github.com/lorenzoli/docker-pdi-ce#build-image)
4. [Usage](https://github.com/lorenzoli/docker-pdi-ce#usage)

**PDI-CE 8.3.0.0-371** require:
- OpenJDK 8
- OpenJRE 8.

# Before start
## Why image required >2GB of disk space ?
**docker-pdi-ce** image is based on Ubuntu 18.04 with Java8 and PDI that increment required disk space.
## What is ermes.sh ?
**ermes.sh** is a bash script that simplify usage of *docker-pdi-ce*.
Available list of commands:
- **build**: this command build docker image from Dockerfile;
- **runt path-to-ktr-file**: this command run transformation file from docker container;
- **runj path-to-kjb-file**: this command run job file from docker container;
- **kill**: clean all images, containers and more.

# Clone projects
```
$ git clone https://github.com/lorenzoli/docker-pdi-ce
```

# Build image
**From ermes.sh**
```
$ ./ermes.sh build
```
**From docker cl**
```
$ docker build --tag=pdi-ce .
```

# Usage
Before run transformation/job you have need to create them with PDI-UI or PDI-xml syntax.<br>
After that the best usage method is the following:
1. create jobs or transformations folder
2. create .kjb or .ktr on this folders
3. run script with job/transformation path.

## Run transformation
**From ermes.sh**
```
$ ./ermes.sh runt <path-to-ktr-file> <optional-parameters>
```
**From docker cl**
```
$ docker run -v <absolute-path-to-ktr-folder>:/opt/transformations pdi-ce sh ./opt/data-integration/pan.sh -file=<path-to-ktr-file>.ktr <optional-parameters>
```

## Run job
**From ermes.sh**
```
$ ./ermes.sh runj <path-to-kjb-file> <optional-parameters>
```
**From docker cl**
```
$ docker run -v <path-to-kjb-folder>:/opt/jobs pdi-ce sh ./opt/data-integration/kitchen.sh -file=<path-to-kjb-file> <optional-parameters>
```
