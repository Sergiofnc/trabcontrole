#!/bin/bash

# Check if the docker daemon is running, as the build system runs in a container
if [ "$(systemctl is-active docker)" = "inactive" ]; then
    echo "Please start docker engine before running this script:"
    echo "> sudo systemctl start docker"
    exit 1
fi

# Create mcux-sdk dir as some commands below will fail without it
if [ ! -d "$(pwd)/mcux-sdk-devel" ]; then
    mkdir "$(pwd)/mcux-sdk-devel"
fi

# Remove any contents that may exist in the host-side mcux-sdk dir to prevent
# old files from other runs from breaking stuff
rm -rf "$(pwd)"/mcux-sdk-devel/*

# Use the container to get the sdk without building the firmware
# bind mounting a dir in the host machine to place the sdk
# Also setting the ownership to user from root to allow the user to delete files, move them, ...
docker run \
    -e OWNER_UID="$UID" \
    -e TERM="$TERM" \
    --rm \
    --name mcuxpresso-install-sdk \
    --mount type=bind,source="$(pwd)/mcux-sdk-devel",target=/home/root/mcux-sdk-mount \
    --entrypoint /home/root/scripts/get_sdk.sh \
    tdx_mcuxpresso:MCUX_2.15.100 \

# When the build fails the container is not cleared, blocking the creation of new containers with the same name
if [[ $(docker ps -a) =~ "mcuxpresso-install-sdk" ]]; then
    echo "Removing temporary container"
    docker rm mcuxpresso-install-sdk
fi
