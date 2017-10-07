#!/bin/sh
# Link this script to /etc/periodic/daily/alpine-armhf
set -e

# Build script config
BUILDPATH="/opt/alpine-armhf"
LOGDIR="${BUILDPATH}/logs"

# Badge configuration
BADGE_STYLE="?style=flat-square"

# Build config
DATE=$(date -u '+%Y-%m-%d')

# Source utilities
source ${BUILDPATH}/badge.sh
source ${BUILDPATH}/cc.sh

notify () {
    : ${1?"usage: notify TEXT"}
    LEVEL=${2:-INFO}
    echo "[$(date -u '+%H:%M:%S')] [$LEVEL] ${1}" 1>&2
}

building () {
    notify "AlpineLinux $ALPINE_RELEASE is currently building"

    # Generate cc.xml
    CCXML_PATH="${LOGDIR}/${ALPINE_RELEASE/v/}/cc.xml"
    BUILD_NAME="orax/alpine-armhf:${ALPINE_RELEASE/v/}"
    BUILD_LABEL=$(date -u '+%Y-%m-%d')
    BUILD_URL="https://armbuild.userctl.xyz/alpine/${ALPINE_RELEASE/v/}/${DATE}.log"
    cc_building

    # # Generate Badge
    # BADGE_PATH="${LOGDIR}/${ALPINE_RELEASE/v/}/status.svg"
    # BADGE_NAME="alpine-armhf:${ALPINE_RELEASE/v/}"
    # badge_building
}

pass () {
    notify "AlpineLinux $ALPINE_RELEASE build passed"

    # Generate Badge
    BADGE_PATH="${LOGDIR}/${ALPINE_RELEASE/v/}/status.svg"
    BADGE_NAME="alpine-armhf:${ALPINE_RELEASE/v/}"
    badge_success

    # Generate cc.xml
    CCXML_PATH="${LOGDIR}/${ALPINE_RELEASE/v/}/cc.xml"
    BUILD_NAME="orax/alpine-armhf:${ALPINE_RELEASE/v/}"
    BUILD_LABEL=$(date -u '+%Y-%m-%d')
    BUILD_URL="https://armbuild.userctl.xyz/alpine/${ALPINE_RELEASE/v/}/${DATE}.log"
    cc_success
}

fail () {
    notify "AlpineLinux $ALPINE_RELEASE build failed" ERROR

    # Generate Badge
    BADGE_PATH="${LOGDIR}/${ALPINE_RELEASE/v/}/status.svg"
    BADGE_NAME="alpine-armhf:${ALPINE_RELEASE/v/}"
    badge_failure

    # Generate cc.xml
    CCXML_PATH="${LOGDIR}/${ALPINE_RELEASE/v/}/cc.xml"
    BUILD_NAME="orax/alpine-armhf:${ALPINE_RELEASE/v/}"
    BUILD_LABEL=$(date -u '+%Y-%m-%d')
    BUILD_URL="https://armbuild.userctl.xyz/alpine/${ALPINE_RELEASE/v/}/${DATE}.log"
    cc_failure
}

# AlpineLinux v3.6
(
    export LOGDIR
    export ALPINE_RELEASE=v3.6
    export IMGTAG="latest ${ALPINE_RELEASE/v/}"
    export BUILD_DATE=$(date "+%FT%T%z")
    building
    ${BUILDPATH}/build.sh && pass || fail
)
# AlpineLinux v3.5
(
    export LOGDIR
    export ALPINE_RELEASE=v3.5
    export IMGTAG="${ALPINE_RELEASE/v/}"
    export BUILD_DATE=$(date "+%FT%T%z")
    building
    ${BUILDPATH}/build.sh && pass || fail
)
# AlpineLinux v3.4
(
    export LOGDIR
    export ALPINE_RELEASE=v3.4
    export IMGTAG="${ALPINE_RELEASE/v/}"
    export BUILD_DATE=$(date "+%FT%T%z")
    building
    ${BUILDPATH}/build.sh && pass || fail
)
# AlpineLinux Edge
(
    export LOGDIR
    export ALPINE_RELEASE=edge
    export IMGTAG=${ALPINE_RELEASE/v/}
    export BUILD_DATE=$(date "+%FT%T%z")
    building
    ${BUILDPATH}/build.sh && pass || fail
)
