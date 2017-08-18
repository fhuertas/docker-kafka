#!/usr/bin/env bash

VERSIONS=(0.9.0.0 0.9.0.1 0.10.0.0 0.10.0.1 0.10.1.0 0.10.1.1 0.10.2.0 0.10.2.1 0.11.0.0)
REPO=fhuertas
IMAGE=docker-kafka
SCALA_VERSIONS=(2.11 2.11 2.11 2.11 2.11 2.11 2.11 2.11 2.11)

for ((i=0;i<${#VERSIONS[@]};++i)); do
    V=${VERSIONS[i]}
	SV=${SCALA_VERSIONS[i]}
    sudo docker build --build-arg SCALA_VERSION=${SV} --build-arg KAFKA_VERSION=${V} -t ${REPO}/${IMAGE}:${V} .
done

if [[ "$1" == "push" ]];then
    
    for ((i=0;i<${#VERSIONS[@]};++i)); do
		sudo docker push ${REPO}/${IMAGE}:${VERSIONS[i]}
	done
fi
