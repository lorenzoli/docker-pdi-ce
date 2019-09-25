#!/bin/bash

# First argument is the task runned
# It can be => build, runt, runj, kill
# build => create docker image with java8 and pdi
# runj => execute specified job
# runt => execute specified transformation
# kill => remove pdi image, not used images and containers
case $1 in
    build)
        # build image with pdi-ce tag
        docker build --tag=pdi-ce .
        echo "Image built"

        # remove not used images and containers
        echo "Clean system..."
        docker container prune -f
        docker image prune -f
        echo "System cleaned."
        ;;
    runt)
        if [ "$#" -ge 2 ]
        then
            # get all character after last /path-to-ktr/*
            filename="${2##*/}"

            # substitute /filename with "" for get file path
            toBeRemoved="/${filename}"
            path="${2/${filename}/}"

            # run transformation
            # map volume from path to opt/transformations on container
            # run ktr file on container with pan.sh script
            docker run -v ${path}:/opt/transformations pdi-ce sh /opt/app/pan.sh -file=/opt/transformations/${filename} $3

            # remove not used images and containers
            echo "Clean system..."
            docker container prune -f
            docker image prune -f
            echo "System cleaned."
        else
            echo "Run transformation require one argument: path to .ktr file"
        fi
        ;;
    runj)
        if [ "$#" -ge 2 ]
        then
            # get all character after /path-to-kjb/*
            filename="${2##*/}"

            # substitute /filename with "" for get file path
            toBeRemoved="/${filename}"
            path="${2/${filename}/}"

            # run job
            # map volume from path to opt/jobs on container
            # run kjb file on container with kitchen.sh script
            docker run -v ${path}:/opt/jobs pdi-ce sh /opt/app/kitchen.sh -file=/opt/jobs/${filename} $3
            
            # remove not used images and containers
            echo "Clean system..."
            docker container prune -f
            docker image prune -f
            echo "System cleaned."
        else
            echo "Run job require one argument: path to .kjb file"
        fi
        ;;
    test)
        # TEST AREA
        # EDIT THIS FOR TEST SAME FEATURES
        # THEN CALL TEST TASK
        # ./goku test {arguments}

        # START example commands
        # get all character after last /
        filename="${2##*/}"

        # substitute filename with nothing for get file path
        toBeRemoved="/${filename}"
        path="${2/${toBeRemoved}/}"

        echo "${path}"
        # END example commands
        ;;
    kill)
        # wait for response
        # y => continue with task
        echo -n "Do you want to delete pdi-ce image ? (y / n) "
        read res
        echo "$res"
        if [ "$res" == "y" ];
        then
            # remove image
            docker rmi pdi-ce

            # remove not used images and containers
            docker container prune -f
            docker image prune -f
            echo "System cleaned."
        else
            echo "Delete execution canceled"
        fi
        ;;
    help)
        echo ""
        echo "usage: ./goku.sh [option] [params]"
        echo ""
        echo "goku script options:"
        echo "build     create docker image with java8 and pdi"
        echo "runt      execute specified transformations"
        echo "runj      execute specified job"
        echo ""
        echo "goku accept standard parameters of kitchen.sh and pan.sh"
        echo "  example: -param:firstParam=test"
        echo "N.B: Before use parameters you have need to configured on transformation or job !"
        echo ""
        ;;
    *)
        echo "Command not found"
        ;;
esac