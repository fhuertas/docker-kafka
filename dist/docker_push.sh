#!/bin/bash

BASE_DIR=$(dirname "${BASH_SOURCE[0]}")

source ${BASE_DIR}/../.config

sudo docker login --username=${docker_repo} -p ${DOCKER_PASSWORD}

for V in $kafka_versions; do
  sudo docker push ${docker_repo}/${docker_image}:${V}
done
