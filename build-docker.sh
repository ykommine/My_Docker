#!/bin/bash
#****************************************************************
# Project        Security
# Company        Harman International
#                All rights reserved
# (c) copyright  2021-24
# Secrecy Level  STRICTLY CONFIDENTIAL
#*****************************************************************
# @file          build-docker.sh
# @author        Kommineni, Yaswanth <Yaswanth.kommineni@harman.com>
# @ingroup       Harman Docker
#*****************************************************************

BUILD_DIR=`pwd`
DOCKER_IMAGE_NAME="dcm24_build_default"
DOCKER_IMAGE_VERSION="0.0.1"
DOCKER_FILENAME="Dockerfile_Ubuntu_v18.04"
DOCKER_DIR="$BUILD_DIR/build-docker"

if ! command -v docker &> /dev/null
then
    echo "Docker does not exit, continuing on host"
	exit -1
fi


#Create docker image if it does not exist
if [[ "$(docker images -q $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION 2> /dev/null)" == "" ]]; then
	echo "*** Start of creating docker image ***"
	docker build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) --build-arg USER_NAME=`whoami` -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION -f "$DOCKER_DIR/$DOCKER_FILENAME" "$DOCKER_DIR" --progress=plain > $BUILD_DIR/docker.out 2>&1
	echo "*** End of creating docker images ***"
fi

echo "*** Start of Docker Image ***"
pwd
docker run -it --rm --init \
	--memory-swap=-1 \
	--ulimit core=-1 \
	-v /data/home/`whoami`/:/root/ \
	-v /usr/bin/p4:/bin/p4/ \
	--workdir=$BUILD_DIR \
	$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION \
	bash -c "/root/My_Docker/login.sh `whoami` /root/My_Docker/"

echo "*** End of Docker Image ***"
