#!/bin/sh
# Link this script to /etc/periodic/daily/alpine-armhf
set -e

# Build script config
BUILDPATH="/opt/alpine-armhf"
LOGDIR="${BUILDPATH}/logs"

update_badge () {
    : ${1?"usage: update-badge BADGE_URL"}
    BADGE="${LOGDIR}/${ALPINE_RELEASE/v/}/status.svg"
    wget -qO ${BADGE} ${1}
}

notify () {
    : ${1?"usage: notify TEXT"}
    LEVEL=${2:-INFO}
    echo "[$(date -u '+%H:%M:%S')] [$LEVEL] ${1}" 1>&2
}

pass () {
    notify "AlpineLinux $ALPINE_RELEASE build passed"
    update_badge "https://img.shields.io/badge/alpine--armhf:${ALPINE_RELEASE/v/}-passing-green.svg?style=flat-square"
}

fail () {
    notify "AlpineLinux $ALPINE_RELEASE build failed" ERROR
    update_badge "https://img.shields.io/badge/alpine--armhf:${ALPINE_RELEASE/v/}-failing-red.svg?style=flat-square"
}

# AlpineLinux v3.4
(
    export LOGDIR
    export ALPINE_RELEASE=v3.4
    export IMGTAG="latest ${ALPINE_RELEASE/v/}"
    ${BUILDPATH}/build.sh && pass || fail
)
# AlpineLinux v3.3
(
    export LOGDIR
    export ALPINE_RELEASE=v3.3
    export IMGTAG=${ALPINE_RELEASE/v/}
    ${BUILDPATH}/build.sh && pass || fail
)
# AlpineLinux Edge
(
    export LOGDIR
    export ALPINE_RELEASE=edge
    export IMGTAG=${ALPINE_RELEASE/v/}
    ${BUILDPATH}/build.sh && pass || fail
)
