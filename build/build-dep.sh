#!/usr/bin/env bash

set -e

BUILD_DIR="$( cd "$( dirname "$0" )" && pwd )"
ENV_DIR="$BUILD_DIR"/env
SCRIPTS_DIR="$BUILD_DIR"/scripts
SRC_DIR="$BUILD_DIR"/sources

DEP_NAME=$1
ENV_FILE="$ENV_DIR/$DEP_NAME"

. "$BUILD_DIR/set-env-vars.sh" "$ENV_FILE"

mkdir -p "$SRC_DIR"
cd "$SRC_DIR" || exit 1
rm -rf "$SUB_DIR"
if [ ! -f "$ARCHIVE_NAME" ]; then
    curl -L "$DOWNLOAD_URL" -o "$ARCHIVE_NAME"
fi
tar xf "$ARCHIVE_NAME"
cd "$SUB_DIR" || exit 1
bash "$SCRIPTS_DIR/$BUILD_SCRIPT"
