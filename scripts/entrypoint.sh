#!/bin/bash

ADVERTISED_PORT=${ADVERTISED_PORT:=9092}

if [[ "${ADVERTISED_HOST}" != "" ]]; then
  echo "advertised.listeners=PLAINTEXT://${ADVERTISED_HOST}:${ADVERTISED_PORT}" >> /opt/kafka/config/server.properties
fi
touch /var/log/sout.log

/etc/init.d/kafka-service.sh start

tail -f /var/log/sout.log
