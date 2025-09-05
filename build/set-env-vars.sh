#!/usr/bin/env bash

# Call with one argument, which must be the path of an existing file in ./env.

set -e

ENV_FILE=$1
DEP_NAME=${ENV_FILE##*/}

BUILD_SCRIPT=""
SUB_DIR=""
ARCHIVE_NAME=""

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

if [ "$ARCHIVE_NAME" == "" ]; then
    ARCHIVE_NAME=${DOWNLOAD_URL##*/}
fi

if [ "$SUB_DIR" == "" ]; then
    SUB_DIR=${ARCHIVE_NAME%.tar.*}
fi

if [ "$BUILD_SCRIPT" == "" ]; then
    BUILD_SCRIPT=$DEP_NAME
fi
