REPO=$1
IMAGE_NAME=$2
VERSION=$3
SCALA_VERSION=$4
DOWNLOAD_URL=$5

echo "build ${REPO}/${IMAGE_NAME}:${VERSION}"

sudo docker build \
  --build-arg DOWNLOAD_URL=${DOWNLOAD_URL} \
  --build-arg SCALA_VERSION=${SCALA_VERSION} \
  --build-arg KAFKA_VERSION=${VERSION} \
  -t ${REPO}/${IMAGE_NAME}:${VERSION} .
