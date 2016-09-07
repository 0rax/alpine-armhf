#!/bin/sh
# https://github.com/erikdoe/ccmenu/wiki/Multiple-Project-Summary-Reporting-Standard

CCXML='<Projects>
    <Project
        name="%s"
        activity="%s"
        lastBuildStatus="%s"
        lastBuildLabel="%s"
        lastBuildTime="%s"
        webUrl="%s"
    />
</Projects>
'

_cc_templating () {
    printf "${CCXML}" "${BUILD_NAME}" "${BUILD_ACTIVITY}" "${BUILD_STATUS}" "${BUILD_LABEL}" "${BUILD_DATE}" "${BUILD_URL}"
}

cc_building () {

    BUILD_NAME=${BUILD_NAME:-$1}
    BUILD_ACTIVITY="Building"
    BUILD_STATUS="Unknown"
    BUILD_LABEL=${BUILD_LABEL:-$2}
    BUILD_DATE=${BUILD_DATE:-$(date "+%FT%T%z")}
    BUILD_URL=${BUILD_URL:-$3}

    _cc_templating
}

cc_success () {

    BUILD_NAME=${BUILD_NAME:-$1}
    BUILD_ACTIVITY="Sleeping"
    BUILD_STATUS="Success"
    BUILD_LABEL=${BUILD_LABEL:-$2}
    BUILD_DATE=${BUILD_DATE:-$(date "+%FT%T%z")}
    BUILD_URL=${BUILD_URL:-$3}

    _cc_templating
}

cc_failure () {

    BUILD_NAME=${BUILD_NAME:-$1}
    BUILD_ACTIVITY="Sleeping"
    BUILD_STATUS="Failure"
    BUILD_LABEL=${BUILD_LABEL:-$2}
    BUILD_DATE=${BUILD_DATE:-$(date "+%FT%T%z")}
    BUILD_URL=${BUILD_URL:-$3}

    _cc_templating
}

cc_exception () {

    BUILD_NAME=${BUILD_NAME:-$1}
    BUILD_ACTIVITY="Sleeping"
    BUILD_STATUS="Exception"
    BUILD_LABEL=${BUILD_LABEL:-$2}
    BUILD_DATE=${BUILD_DATE:-$(date "+%FT%T%z")}
    BUILD_URL=${BUILD_URL:-$3}

    _cc_templating
}
