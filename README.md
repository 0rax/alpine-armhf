# orax/alpine-armhf
[![Build Status](https://armbuild.userctl.xyz/alpine/stable/status.svg)](https://armbuild.userctl.xyz/alpine/stable/current.log)
[![Docker Pulls](https://img.shields.io/docker/pulls/orax/alpine-armhf.svg?style=flat-square?maxAge=3600)](https://hub.docker.com/r/orax/alpine-armhf/) [![Gitter](https://img.shields.io/gitter/room/orax/alpine-armhf.svg?style=flat-square?maxAge=2592000)](https://gitter.im/0rax/alpine-armhf)

## Deprecation notice

After providing this image for more multiple years, it is now considered deprecated and this repository will be archived.

With the evolution of the Docker platform in the past years and with an official image now being provided for the ARM and ARM64 platform on the Docker Hub, I feel like continuing to work on this repository is no longer worth the effort.

I suggest that anybody still using this image to migrate to the official [`alpine`](https://hub.docker.com/_/alpine) image available on the Docker hub.

The Docker Hub repository for this image will remain available for a while but, as the server used for building will be terminated, build logs won't be accessible from now on.

## Introduction

This repository contains the source of a cron-script run everyday in order to create and up-to-date Alpine Linux Docker container for ARMHF.

The goal is to provide a base container that contains all the latest security patches available.

## Containers

 Container | Build Status | Build Log | CC.xml
:----------|:-------------|:---------:|:-------:
[orax/alpine-armhf:3.4](https://hub.docker.com/r/orax/alpine-armhf/) | [![Build Status](https://armbuild.userctl.xyz/alpine/3.4/status.svg)](https://armbuild.userctl.xyz/alpine/3.4/current.log) | [current.log](https://armbuild.userctl.xyz/alpine/3.4/current.log) | [cc.xml](https://armbuild.userctl.xyz/alpine/3.4/cc.xml)
[orax/alpine-armhf:3.5](https://hub.docker.com/r/orax/alpine-armhf/) | [![Build Status](https://armbuild.userctl.xyz/alpine/3.5/status.svg)](https://armbuild.userctl.xyz/alpine/3.5/current.log) | [current.log](https://armbuild.userctl.xyz/alpine/3.5/current.log) | [cc.xml](https://armbuild.userctl.xyz/alpine/3.5/cc.xml)
[orax/alpine-armhf:3.6](https://hub.docker.com/r/orax/alpine-armhf/) | [![Build Status](https://armbuild.userctl.xyz/alpine/3.6/status.svg)](https://armbuild.userctl.xyz/alpine/3.6/current.log) | [current.log](https://armbuild.userctl.xyz/alpine/3.6/current.log) | [cc.xml](https://armbuild.userctl.xyz/alpine/3.6/cc.xml)
[orax/alpine-armhf:3.7](https://hub.docker.com/r/orax/alpine-armhf/) | [![Build Status](https://armbuild.userctl.xyz/alpine/3.7/status.svg)](https://armbuild.userctl.xyz/alpine/3.7/current.log) | [current.log](https://armbuild.userctl.xyz/alpine/3.7/current.log) | [cc.xml](https://armbuild.userctl.xyz/alpine/3.7/cc.xml)
[orax/alpine-armhf:3.8](https://hub.docker.com/r/orax/alpine-armhf/) | [![Build Status](https://armbuild.userctl.xyz/alpine/3.8/status.svg)](https://armbuild.userctl.xyz/alpine/3.8/current.log) | [current.log](https://armbuild.userctl.xyz/alpine/3.8/current.log) | [cc.xml](https://armbuild.userctl.xyz/alpine/3.8/cc.xml)
[orax/alpine-armhf:edge](https://hub.docker.com/r/orax/alpine-armhf/) | [![Build Status](https://armbuild.userctl.xyz/alpine/edge/status.svg)](https://armbuild.userctl.xyz/alpine/edge/current.log) | [current.log](https://armbuild.userctl.xyz/alpine/edge/current.log) | [cc.xml](https://armbuild.userctl.xyz/alpine/edge/cc.xml)
