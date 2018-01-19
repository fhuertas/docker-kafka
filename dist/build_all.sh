BASE_DIR=$(dirname "${BASH_SOURCE[0]}")
source ${BASE_DIR}/../.config
for V in $kafka_versions; do
  ${BASE_DIR}/build_version.sh $docker_repo $docker_image $V $scala_version $base_url
done
