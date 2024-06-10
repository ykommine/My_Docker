#!/bin/bash
#****************************************************************
# Project        Security
# Company        Harman International
#                All rights reserved
# (c) copyright  2021-24
# Secrecy Level STRICTLY CONFIDENTIAL
#*****************************************************************
# @file          login.sh
# @author        Kommineni, Yaswanth <Yaswanth.kommineni@harman.com>
# @ingroup       Harman Docker
#*****************************************************************

USER_NAME=$1
WORKSPC=$2

#install the locals
apt-get install locales
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8

#update the docker character encoding to UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

#Configure the locals
sudo dpkg-reconfigure --frontend=noninteractive locales
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

#Login to the New User
su - $USER_NAME -c "cd $WORKSPC && pwd && whoami && /bin/bash"

