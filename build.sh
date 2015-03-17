#!/bin/bash

set -e -u

DOCKER_REGISTRY="${1}"
PARENT_IMAGE="${2:-}"

image="${DOCKER_REGISTRY}/apps/logstash"

tag="$( git describe --always --dirty )"
if [ -n "${BUILD_NUMBER:-}" ]; then
    tag="${tag}-${BUILD_NUMBER}"
fi

sed -i -e "/^FROM/cFROM ${PARENT_IMAGE}" Dockerfile
docker pull "${PARENT_IMAGE}"

docker build -t "${image}:${tag}" .
docker tag --force "${image}:${tag}" "${image}:latest"
docker push "${image}:${tag}"
docker push "${image}:latest"
docker rmi --force $( docker inspect --format '{{ .Id }}' "${image}:${tag}" )

echo "image=${image}" >| docker_build.properties
echo "tag=${tag}" >> docker_build.properties
