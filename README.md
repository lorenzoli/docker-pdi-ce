# docker-pdi
Dockerize [Pentaho Data Integration CE](https://community.hitachivantara.com/s/article/data-integration-kettle) version 8.3.0.0-370.
Docker image version 1.0.0.

# About
Pentaho Data Integration (PDI) provides the Extract, Transform, and Load (ETL) capabilities that facilitates the process of capturing, cleansing, and storing data using a uniform and consistent format that is accessible and relevant to end users and IoT technologies.

This version of docker image doesn't permits to execute PDI UI for create new transformations or jobs.

**Pdi 8.3.0.0-370** require:
- OpenJDK 8
- OpenJRE 8.

# Download resources
```
$ git clone https://github.com/lorenzoli/docker-pdi
```
## What is goku.sh ?
**goku.sh** is a bash script that simplify usage of *docker-pdi*.
Available list of commands:
- **build**: this command build docker image from Dockerfile;
- **runt path-to-ktr-file**: this command run transformation file from docker container;
- **runj path-to-kjb-file**: this command run job file from docker container;

# Build image
**From goku.sh**
```
$ ./goku.sh build
```
**From docker cl**
```
$ docker build --tag=pdi-ce .
```

# Run job
**From goku.sh**
```
$ ./goku.sh runj <path-to-kjb-file>
```
**From docker cl**
```
$ docker runj pdi-ce sh ./opt/App/kitchen.sh -file=<path-to-kjb-file>
```


# Run transformation
**From goku.sh**
```
$ ./goku.sh runt <path-to-ktr-file>.ktr
```
**From docker cl**
```
$ docker runt pdi-ce sh ./opt/App/pan.sh -file=<path-to-ktr-file>.ktr
```
