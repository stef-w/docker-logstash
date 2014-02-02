#!/bin/bash

set -e

IMAGE="zardoz.podzone.org:11003/apps/logstash"

docker build -t ${IMAGE} .
docker push ${IMAGE}
