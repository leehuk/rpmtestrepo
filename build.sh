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

docker_build() {
    shortname="$1"
    longname="$2"

    buildname="leehuk/rpmtestrepo:$shortname-build"

    echo "Building $buildname"
    docker build -t $buildname -f dockerfiles/Dockerfile-$longname.build . || bail "Docker $longname initial build failed"
    docker_extract $buildname "/home/rpmbuild/rpmtestrepo.tgz" "tmp/rpmtestrepo-$shortname.tgz"

    releasename="leehuk/rpmtestrepo:$longname"

    echo "Building $releasename"
    docker build -t $releasename -f dockerfiles/Dockerfile-$longname.release . || bail "Docker $longname release build failed"
}

docker_build "c6" "centos6"
docker_build "c7" "centos7"
docker_build "fed27" "fedora27"
