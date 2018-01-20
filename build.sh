#!/bin/bash

bail() {
    echo "Error: $1"
    exit 1
}

docker_extract() {
    image="$1"
    file="$2"
    outfile="$3"

    docker rm -f rpmtestrepo-build 2>/dev/null
    docker create --name rpmtestrepo-build $image
    docker cp rpmtestrepo-build:"$file" "$outfile"
    docker rm -f rpmtestrepo-build
}

echo "Building leehuk/rpmtestrepo:c6-build"
docker build -t leehuk/rpmtestrepo:c6-build -f dockerfiles/Dockerfile-centos6.build . || bail "Docker initial build failed"
docker_extract "leehuk/rpmtestrepo:c6-build" "/home/rpmbuild/rpmtestrepo.tgz" "tmp/rpmtestrepo-c6.tgz"

echo "Building leehuk/rpmtestrepo:centos6"
docker build -t leehuk/rpmtestrepo:centos6 -f dockerfiles/Dockerfile-centos6.release . || bail "Docker release build failed"

echo "Building leehuk/rpmtestrepo:c7-build"
docker build -t leehuk/rpmtestrepo:c7-build -f dockerfiles/Dockerfile-centos7.build . || bail "Docker initial build failed"
docker_extract "leehuk/rpmtestrepo:c7-build" "/home/rpmbuild/rpmtestrepo.tgz" "tmp/rpmtestrepo-c7.tgz"

echo "Building leehuk/rpmtestrepo:centos7"
docker build -t leehuk/rpmtestrepo:centos7 -f dockerfiles/Dockerfile-centos7.release . || bail "Docker release build failed"
