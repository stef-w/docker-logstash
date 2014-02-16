#!/bin/bash

set -e

IMAGE="zardoz.podzone.org:11003/apps/logstash"

docker build -rm -t ${IMAGE} .
docker push ${IMAGE}
