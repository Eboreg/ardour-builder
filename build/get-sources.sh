#!/usr/bin/env bash

set -e

BUILD_DIR="$( cd "$( dirname "$0" )" && pwd )"
ENV_DIR="$BUILD_DIR"/env
SOURCE_DIR="$BUILD_DIR"/sources

DEP_NAME=$1
ENV_FILE="$ENV_DIR/$DEP_NAME"

. "$BUILD_DIR/set-env-vars.sh" "$ENV_FILE"

mkdir -p "$SOURCE_DIR"

if [ -n "$GIT_REPO" ]; then
    git clone "$GIT_REPO" "$SUB_DIR"
    cd "$SUB_DIR" || exit 1
    if [ -n "$GIT_CHECKOUT" ]; then
        git checkout "$GIT_CHECKOUT"
    fi
else
    if [ ! -f "$ARCHIVE_NAME" ]; then
        curl -L "$DOWNLOAD_URL" -o "$ARCHIVE_NAME"
    fi
    tar xf "$ARCHIVE_NAME"
    cd "$SUB_DIR" || exit 1
fi
