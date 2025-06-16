#!/bin/bash

# Uncomment this to stop the script if anything fails (return non zero)
# set -e

# Check if the CLI arg has been provided
# As the build breaks in a spectacular way if this param is not provided
# This "if" checks if the expansion of the first arg is a null string
if [ -z "$1" ]; then
    echo "Missing argument: Build type (debug, release, ...):"
    echo "> ./run.sh debug"
    echo "Check the available build types used for \"-DCMAKE_BUILD_TYPE=\" in \"$(pwd)/armgcc/build_all.sh\""
    exit 1
fi

# Check if the docker daemon is running, as the build system runs in a container
if [ "$(systemctl is-active docker)" = "inactive" ]; then
    echo "Please start docker engine before running this script:"
    echo "> sudo systemctl start docker"
    exit 1
fi

# Use the container to build the firmware, bind mounting the project to provide the files
docker run \
    -e BUILD_TYPE="$1" \
    -e OWNER_UID="$UID" \
    -e TERM="$TERM" \
    --rm \
    --name mcuxpresso \
    --mount type=bind,source="$(pwd)",target=/home/root/project_files \
    tdx_mcuxpresso:MCUX_2.15.100

# When the build fails the container is not cleared, blocking the creation of new containers with the same name
if [[ $(docker ps -a) =~ "mcuxpresso" ]]; then
    echo "Removing temporary container"
    docker rm mcuxpresso
fi
