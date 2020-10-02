#!/bin/sh

DIR=$1
TAG=$2

cd ${DIR} && \
docker build --pull --force-rm -t 2224/asterisk:${TAG} --file ./Dockerfile . && \
docker run -d --rm --name asterisk-${TAG} 2224/asterisk:${TAG} && \
sleep 3 && \
docker exec -ti asterisk-${TAG} sh -c 'cat /etc/iss*' && \
docker exec -ti asterisk-${TAG} sh -c 'asterisk -rx "core show version"; exit $?' && echo "ok $?" || echo "not ok" ; \
docker stop asterisk-${TAG}; \
cd ..
