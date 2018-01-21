# rpmtestrepo
Docker images useful for testing rpm repository tools

## Overview
These images provide a simple rpm test package `rpmtestpackage` in versions 
`1.0-1` and` 1.1-1`, within a local yum-compatible rpm repo with the appropriate 
yum.repos.d configuration. Used primarily for testing of updates to rpm 
tooling, such as repo diffing or validating lists of updates.

## Build Status
[![Build Status](https://travis-ci.org/leehuk/rpmtestrepo.svg?branch=master)](https://travis-ci.org/leehuk/rpmtestrepo)

## Contents
All Docker builds contain two repositories with the following contents:
```
[rpmtestrepo-1.0] /usr/share/rpmtestrepo-1.0/
  rpmtestpackage-1.0-1.noarch.rpm
  
[rpmtestrepo-1.1] /usr/share/rpmtestrepo-1.1/
  rpmtestpackage-1.0-1.noarch.rpm
  rpmtestpackage-1.1-1.noarch.rpm
```

## Docker Images
Docker images available from https://hub.docker.com/r/leehuk/rpmtestrepo/
* leehuk/rpmtestrepo:centos6
* leehuk/rpmtestrepo:centos7
* leehuk/rpmtestrepo:fedora27

## Test Suite
Test status can be found on Travis: https://travis-ci.org/leehuk/rpmtestrepo
