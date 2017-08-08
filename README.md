Kafka in Docker
===

This repository provides everything you need to run Kafka in Docker. It is based
on the [spotify/docker-kafka](https://github.com/spotify/docker-kafka) repository.  


Why?
---

[spotify/docker-kafka](https://github.com/spotify/docker-kafka) it provides of a kafka docker image that contains a specific kafka version (the last version was 0.10.1.0) but it is useful to have similar images with other versions. This repo contain a parametrizable docker file and the public builds is tagged with the same kafka version that provedes
Run


```bash
docker run -p 2181:2181 -p 9092:9092 --env ADVERTISED_HOST=`docker-machine ip \`docker-machine active\`` --env ADVERTISED_PORT=9092 fhuertas/docker-kafka
```

Public Builds
---

https://hub.docker.com/r/fhuertas/docker-kafka/


Build from Source
---
This is a example for scala 2.11 and kafka 0.10.0.1
```bash
docker build -t kafka:0.10.0.1 --build-arg SCALA_VERSION=2.11 --build-arg KAFKA_VERSION=0.10.0.1 .
```    

Todo
---

* More builds
