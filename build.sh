#!/bin/bash

echo "Building leehuk/rpmtestrepo:c7-build"
docker build -t leehuk/rpmtestrepo:c7-build -f dockerfiles/Dockerfile-centos7.build .

docker rm -f rpmtestrepo-c7 2>/dev/null
docker create --name rpmtestrepo-c7 leehuk/rpmtestrepo:c7-build
docker cp rpmtestrepo-c7:/home/rpmbuild/rpmtestrepo.tgz tmp/rpmtestrepo-c7.tgz
docker rm -f rpmtestrepo-c7

echo "Building leehuk/rpmtestrepo:centos7"
docker build -t leehuk/rpmtestrepo:centos7 -f dockerfiles/Dockerfile-centos7.release .
