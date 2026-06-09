#!/usr/bin/env bash

# Call with one argument, which must be the path of an existing file in ./env.

set -e

ENV_FILE=$1
DEP_NAME=${ENV_FILE##*/}

BUILD_SCRIPT=""
SUB_DIR=""
ARCHIVE_NAME=""
DOWNLOAD_URL=""
GIT_REPO=""

if [ "$DEP_NAME" == "" ]; then
    echo "!!! set-env-vars.sh called without argument"
    exit 1
fi

if [ ! -f "$ENV_FILE" ]; then
    echo "!!! $ENV_FILE does not exist"
    exit 1
fi

# shellcheck disable=SC1090
. "$ENV_FILE"

if [ "$DOWNLOAD_URL" == "" ] && [ "$GIT_REPO" == "" ]; then
    echo "!!! Either DOWNLOAD_URL or GIT_REPO must be defined"
    exit 1
fi

if [ "$ARCHIVE_NAME" == "" ] && [ -n "$DOWNLOAD_URL" ]; then
    ARCHIVE_NAME=${DOWNLOAD_URL##*/}
fi

if [ "$SUB_DIR" == "" ]; then
    if [ -n "$ARCHIVE_NAME" ]; then
        SUB_DIR=${ARCHIVE_NAME%.tar.*}
    elif [ -n "$GIT_REPO" ]; then
        SUB_DIR=${GIT_REPO%.git}
        SUB_DIR=${SUB_DIR##*/}
    fi
fi

if [ "$BUILD_SCRIPT" == "" ]; then
    BUILD_SCRIPT=$DEP_NAME
fi
