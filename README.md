#####################STEPS TO RUN THE DOCKER SCRIPT#####################

***********IMPORTANT FILES***********
#1. Dockerfile_Ubuntu_v18.04 - Contains the docker container info and dependencies.
#2. build-docker.sh - Script to build and launch the docker container.
#3. login.sh - Script to login the user as the existing local user.

#######STEPS########
# Clone the DCM24 repo inside the My_Docker env and make the gclient sync.
# Run the build-docker.sh script to build the docker image and login to it
# Once you run the script, you will be taken to a docker container with your HARMAN user_name and random docker address.
# Now you will be able to see the cloned repo of DCM24 and you can enter into it and export the command and perform the source command to build the yocto.


