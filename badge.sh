#!/bin/sh
# https://shields.io/

BADGE_SERVER=${BADGE_SERVER:-"https://img.shields.io/badge"}
BADGE_STYLE=${BADGE_STYLE:-""}
BADGE_URL_TPL="${BADGE_SERVER}/%s-%s-%s.svg${BADGE_STYLE}"

_badge_update () {

    BADGE_LABEL=$(echo "${BADGE_NAME}" | sed 's/-/--/g')
    BADGE_URL=$(printf "${BADGE_URL_TPL}" ${BADGE_LABEL} ${BADGE_TEXT} ${BADGE_COLOR})

    wget -qO ${BADGE_PATH} ${BADGE_URL}
}

badge_building () {

    BADGE_NAME=${BADGE_NAME:-$1}
    BADGE_PATH=${BADGE_PATH:-$2}
    BADGE_COLOR="lightgrey"
    BADGE_TEXT="building"

    _badge_update
}

badge_success () {

    BADGE_NAME=${BADGE_NAME:-$1}
    BADGE_PATH=${BADGE_PATH:-$2}
    BADGE_COLOR="green"
    BADGE_TEXT="passing"

    _badge_update
}

badge_failure () {

    BADGE_NAME=${BADGE_NAME:-$1}
    BADGE_PATH=${BADGE_PATH:-$2}
    BADGE_COLOR="red"
    BADGE_TEXT="failing"

    _badge_update
}
