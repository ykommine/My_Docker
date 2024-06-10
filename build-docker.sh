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
if [ -z ${TOYOTA_DEPS} ];
then
    echo "ERROR: TOYOTA_DEPS export is mandatory";
    exit -1
else
    echo "DEPS path: ${TOYOTA_DEPS}"
fi

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

START=$(echo "$TOYOTA_DEPS" | awk -v user=`whoami` '{split($0, parts, user); print parts[2]}' | awk -F'/My_Docker' '{print $1}')

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
	bash -c "/root/$START/My_Docker/login.sh `whoami` /root/$START/My_Docker/"

echo "*** End of Docker Image ***"
