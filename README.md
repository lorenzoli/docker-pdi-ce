# docker-pdi-ce
Dockerize [Pentaho Data Integration CE](https://community.hitachivantara.com/s/article/data-integration-kettle) version 8.3.0.0-371.
Docker image version 1.0.0.

# About
Pentaho Data Integration (PDI) provides the Extract, Transform, and Load (ETL) capabilities that facilitates the process of capturing, cleansing, and storing data using a uniform and consistent format that is accessible and relevant to end users and IoT technologies.

This version of docker image doesn't permits to execute PDI UI for create new transformations or jobs.

# Index
1. [Before start](https://github.com/lorenzoli/docker-pdi-ce#before-start)
2. [Clone project](https://github.com/lorenzoli/docker-pdi-ce#clone-projects)
3. [Build image](https://github.com/lorenzoli/docker-pdi-ce#build-image)
4. [Run transformation](https://github.com/lorenzoli/docker-pdi-ce#run-transformation) or [Run job](https://github.com/lorenzoli/docker-pdi-ce#run-job)

**PDI-CE 8.3.0.0-371** require:
- OpenJDK 8
- OpenJRE 8.

# Before start
## What is goku.sh ?
**goku.sh** is a bash script that simplify usage of *docker-pdi-ce*.
Available list of commands:
- **build**: this command build docker image from Dockerfile;
- **runt path-to-ktr-file**: this command run transformation file from docker container;
- **runj path-to-kjb-file**: this command run job file from docker container;
- **kill**: clean all images, containers and more.
## Why image required 3.5 GB of disk space ?
**docker-pdi-ce** image is based on Ubuntu 18.04 with Java8 and PDI that increment required disk space.

# Clone projects
```
$ git clone https://github.com/lorenzoli/docker-pdi-ce
```

# Build image
**From goku.sh**
```
$ ./goku.sh build
```
**From docker cl**
```
$ docker build --tag=pdi-ce .
```

# Run transformation
**From goku.sh**
```
$ ./goku.sh runt <path-to-ktr-file> <optional-parameters>
```
**From docker cl**
```
$ docker run -v <absolute-path-to-ktr-folder>:/opt/transformations pdi-ce sh ./opt/app/pan.sh -file=<path-to-ktr-file>.ktr <optional-parameters>
```

# Run job
**From goku.sh**
```
$ ./goku.sh runj <path-to-kjb-file> <optional-parameters>
```
**From docker cl**
```
$ docker run -v <path-to-kjb-folder>:/opt/jobs pdi-ce sh ./opt/app/kitchen.sh -file=<path-to-kjb-file> <optional-parameters>
```
