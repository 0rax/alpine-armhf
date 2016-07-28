#!/bin/sh
# http://alpinelinux.org/
set -e
cd $(dirname $(readlink $0 || echo $0))

# Target Arch
APKARCH="armhf"

# Alpine APK repository config
ALPINE_RELEASE=${ALPINE_RELEASE:-edge}
ALPINE_MIRROR=http://dl-cdn.alpinelinux.org/alpine
ALPINE_MAIN=${ALPINE_MIRROR}/${ALPINE_RELEASE}/main
ALPINE_COMMUNITY=${ALPINE_MIRROR}/${ALPINE_RELEASE}/community
ALPINE_REPOS="${ALPINE_MAIN} ${ALPINE_COMMUNITY}"

# System base package
BASE_PACKAGE=${BASE_PACKAGE:-"alpine-baselayout alpine-keys apk-tools libc-utils"}

# Container build config
IMGNAME=${IMGNAME:-"orax/alpine-${APKARCH}"}
IMGTAG=${IMGTAG:-"latest ${ALPINE_RELEASE/v/}"}
DOCKERFILE=Dockerfile
BUILDOPT=${BUILDOPT:-"--no-cache --force-rm --quiet"}
TARNAME=rootfs.tar.gz

# Log Config
LOGDIR=${LOGDIR:-"logs"}
DATE=$(date -u '+%Y-%m-%d')
LOGFILE=${LOGDIR}/${ALPINE_RELEASE}/${DATE}.log

# Docker labels & tags
BUILDDATE=$(date -u '+%Y-%m-%d')
BUILDTIME=$(date -u '+%H:%M:%S')
DOCKERLABELS="--label=BuildDate=${BUILDDATE}
              --label=BuildTime=${BUILDTIME}
              --label=AlpineRelease=${ALPINE_RELEASE/v/}"
DOCKERIMG=$(for tag in ${IMGTAG}; do echo " ${IMGNAME}:${tag}"; done | tr -d '\n')
DOCKERTAGS="${DOCKERIMG// / --tag=}"

# Temp dir
TMPDIR=$(mktemp -d /tmp/$(basename ${IMGNAME})-XXXXXX)
ROOTFS=${TMPDIR}/rootfs
ROOTTAR=${TMPDIR}/tar/${TARNAME}

buildlog () {
    mkdir -p $(dirname $LOGFILE)
    >${LOGFILE}
    exec 2>>${LOGFILE}
    exec 1>>${LOGFILE}
    ln -sf ${LOGFILE} $(dirname $LOGFILE)/current.log
}

buildinfo () {
    echo "--- --- --- --- --- BEGIN BUILD --- --- --- --- ---"  >&2
    echo "--- OS Base   : Alpine Linux"                         >&2
    echo "--- OS Release: ${ALPINE_RELEASE}"                    >&2
    echo "--- OS Arch   : ${APKARCH}"                           >&2
    echo "--- Build Date: ${BUILDDATE}"                         >&2
    echo "--- Build Time: ${BUILDTIME}"                         >&2
    echo "--- Dockerfile: $DOCKERFILE"                          >&2
    for img in ${DOCKERIMG}; do
    echo "--- Docker Img: $img"                                 >&2
    done
    echo "--- --- --- --- --- --- --- --- --- --- --- --- ---"  >&2
}

debug () {
    set -x
}

prepare () {
    mkdir -p $(dirname ${ROOTTAR}) ${ROOTFS} ${ROOTFS}/sbin ${ROOTFS}/etc ${ROOTFS}/usr/bin
}

getapk () {
    APKV=$(
        curl -s $ALPINE_MAIN/$APKARCH/APKINDEX.tar.gz | tar -Oxz \
         | grep '^P:apk-tools-static$' -a -A1 | tail -n1 | cut -d: -f2
    )
    APKURL=$ALPINE_MAIN/$APKARCH/apk-tools-static-$APKV.apk
    curl -s $APKURL | tar xz -C $TMPDIR sbin/apk.static
}

fetchbase () {
    APKOPT=$(for repo in $ALPINE_REPOS; do echo "--repository $repo"; done)
    APKOPT="$APKOPT --update-cache --allow-untrusted --initdb --root $ROOTFS"
    $TMPDIR/sbin/apk.static $APKOPT add $BASE_PACKAGE
}

configrepo () {
    mkdir -p $TMPDIR/rootfs/etc/apk/
    echo $ALPINE_REPOS | tr " " "\n" | tee $TMPDIR/rootfs/etc/apk/repositories
}

tarrootfs () {
    tar cfz $ROOTTAR --numeric-owner --exclude "APKINDEX.*.tar.gz" -C $TMPDIR/rootfs .
}

dockerize () {
    dfile="$(dirname $ROOTTAR)/$(basename $DOCKERFILE)"
    cp $DOCKERFILE $dfile
    docker build $BUILDOPT $DOCKERTAGS $DOCKERLABELS --file=$dfile $(dirname $ROOTTAR)
}

pushdocker () {
    for img in ${DOCKERIMG}; do
        docker push $img
    done
}

cleanup () {
    rm -rf ${TMPDIR}
    set +x
    echo "--- --- --- --- --- END   BUILD --- --- --- --- ---"  >&2
}

trap cleanup EXIT

buildlog
buildinfo
debug
prepare
getapk
fetchbase
configrepo
tarrootfs
dockerize
pushdocker
