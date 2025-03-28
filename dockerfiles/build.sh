#!/usr/bin/env bash

# Check that one argument has been given
if [ ${#} -ne "1" ]; then
  echo "Usage: \"build.sh DOCKERFILE\""
  exit 1
fi

DOCKERFILE_PATH=${1}

# Check that the argument isn't ros.Dockerfile or user.Dockerfile
if [[ ${DOCKERFILE_PATH} = "ros.Dockerfile" || ${DOCKERFILE_PATH} = "user.Dockerfile" ]]; then
  echo "Invalid argument: ${DOCKERFILE_PATH} should not be passed to this script"
  exit 1
fi

# Check that the Dockerfile exists
if [ ! -f "${DOCKERFILE_PATH}" ]; then
  echo "${DOCKERFILE_PATH} not found"
  exit 1
fi

# Get the image name from the filename by removing ".Dockerfile" and any subdirectory
IMAGE_NAME=${DOCKERFILE_PATH%%.Dockerfile}
IMAGE_NAME=${IMAGE_NAME##*/}

# Concatenate Dockerfiles and build image
cat ${DOCKERFILE_PATH} ros.Dockerfile user.Dockerfile | \
  docker build --build-arg UID=$(id -u) --build-arg USER=${USER} -t ${IMAGE_NAME} -f - .
