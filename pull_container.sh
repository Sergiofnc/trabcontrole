#!/bin/bash

# v=1/2 --> MCUXpresso 2.15.100
DOCS_VERSION_TAG="3"

# Check for curl
if [ -z "$(which curl)" ]; then
    echo "Please install cURL, then re-run this script."
    exit 1
fi

# Check if the docker daemon is running, as it is required to run "docker load"
if [ "$(systemctl is-active docker)" = "inactive" ]; then
    echo "Please start docker engine before running this script:"
    echo "> sudo systemctl start docker"
    exit 1
fi

# Get a temporary file name
CONTAINER_TMP_FILE="$(mktemp /tmp/tdx_mcuxpresso_XXXXXXXX.tar.zst)"

# Fetch the container img
echo "Downloading container image to '$CONTAINER_TMP_FILE'"
curl -L "https://docs.toradex.com/private/115261-tdx_mcuxpresso.zst?v=$DOCS_VERSION_TAG" -o "$CONTAINER_TMP_FILE"

# Add the container image to Docker
echo "Adding container image to Docker"
docker load -i "$CONTAINER_TMP_FILE"

# Delete the tarball as it is no longer necessary
rm "$CONTAINER_TMP_FILE"
