#!/bin/bash
export KAFKA_PATH=/opt/kafka
export ZOO_PID=`cat ${KAFKA_PATH}/zoo.pid`
export KAFKA_PID=`cat ${KAFKA_PATH}/kafka.pid`

function check_services () {
  ZOO_ST=""
  KAFKA_ST=""
  if [[ "$ZOO_PID" != "" ]] && [[ -e /proc/$ZOO_PID ]]; then
    export ZOO_ST=true
  fi
  if [[ "$KAFKA_PID" != "" ]] && [[ -e /proc/$KAFKA_PID ]]; then
    export KAFKA_ST=true
  fi
}

check_services

function main () {
  case $1 in
    start)
      if [[ $ZOO_ST == "" ]]; then
        echo "Starting Zookeeper"
        nohup ${KAFKA_PATH}/bin/zookeeper-server-start.sh ${KAFKA_PATH}/config/zookeeper.properties >> /var/log/zoo.log >> /var/log/sout.log 2>&1&
        ZOO_PID=$!
        echo -n $ZOO_PID > ${KAFKA_PATH}/zoo.pid
        echo "Zookeeper started on 2181 (PID=$ZOO_PID). Waiting 2 Sec."
        sleep 2
      else
        echo "ERROR: Zookeeper is running on 2181"
      fi
      if [[ $KAFKA_ST == "" ]]; then
        echo "Starting Kafka"
        nohup ${KAFKA_PATH}/bin/kafka-server-start.sh ${KAFKA_PATH}/config/server.properties >> /var/log/kafka.log >> /var/log/sout.log 2>&1&
        KAFKA_PID=$!
        echo -n $KAFKA_PID > ${KAFKA_PATH}/kafka.pid
        echo "Kafka started on 9092 (PID=$KAFKA_PID)"
      else
        echo "ERROR: Kafka is running on 9092"
      fi
    ;;
    stop)
      if [[ $KAFKA_ST == "" ]]; then
        echo "ERROR: Kafka is not running"
      else
        echo "Stoping Kafka (PID=$KAFKA_PID)"
        kill $KAFKA_PID
        echo "Kafka stoped. Waiting 2 Sec."
        sleep 2
      fi

      if [[ $ZOO_ST == "" ]]; then
        echo "ERROR: Zookeeper is not running"
      else
        echo "Stoping Zookeeper (PID=$ZOO_PID)"
        kill $ZOO_PID
      fi
    ;;
    force-stop)
      echo "Trying to stop the service without forcing"
      main stop
      echo "Waiting 2 Sec. (normal stop)"
      sleep 2
      check_services
      if [[ $KAFKA_ST == "" ]]; then
        echo "INFO: Kafka is not running"
      else
        echo "Stoping Kafka (PID=$KAFKA_PID)"
        kill -9 $KAFKA_PID
        echo "Kafka stoped."
      fi

      if [[ $ZOO_ST == "" ]]; then
        echo "INFO: Zookeeper is not running"
      else
        echo "Stoping Zookeeper (PID=$ZOO_PID)"
        kill -9 $ZOO_PID
      fi
    ;;
    status)
      if [[ $ZOO_ST == "" ]]; then
        echo "Zookeeper is not running"
      else
        echo "Zookeeper is running on 2181 (PID=$ZOO_PID)"
      fi
      if [[ $KAFKA_ST == "" ]]; then
        echo "Kafka is not running"
      else
        echo "Kafka is running on 9092 (PID=$KAFKA_PID)"
      fi
    ;;
    *)
      echo "Usage: $0 (start|stop|force-stop|status|help)"
    ;;
  esac
}

main $1
