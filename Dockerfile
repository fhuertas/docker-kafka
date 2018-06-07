# Kafka and Zookeeper

FROM java:openjdk-8-jre

ENV DEBIAN_FRONTEND noninteractive
ARG SCALA_VERSION
ARG KAFKA_VERSION
ARG DOWNLOAD_URL
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"
ENV URL_BASE "$DOWNLOAD_URL"/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz
# Install Kafka, Zookeeper and other needed things

RUN wget -q $URL_BASE -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz && \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && \
    mv /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"/ /opt/kafka && \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz && \
    echo "export PATH=$PATH:/opt/kafka/bin" >> /etc/bash.bashrc 

ADD scripts/kafka-service.sh /etc/init.d/
ADD scripts/entrypoint.sh /entrypoint.sh

RUN chmod +x /etc/init.d/kafka-service.sh /entrypoint.sh

# 2181 is zookeeper, 9092 is kafka
EXPOSE 2181 9092

ENTRYPOINT ["/entrypoint.sh"]
