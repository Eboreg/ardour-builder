#!/usr/bin/env bash

set -e

ROOT_DIR="$( cd "$( dirname "$0" )" && pwd )"
mkdir -p "$ROOT_DIR"/build/sources

for envfile in "$ROOT_DIR"/build/env/*; do
    . "$ROOT_DIR/build/set-env-vars.sh" "$envfile"
    ARCHIVE_PATH=$ROOT_DIR/build/sources/$ARCHIVE_NAME
    if [ ! -f "$ARCHIVE_PATH" ]; then
        echo "Downloading $DOWNLOAD_URL to $ARCHIVE_PATH"
        curl -L "$DOWNLOAD_URL" -o "$ARCHIVE_PATH"
    fi
done

docker build . -t ardour
CONTAINER_ID=$(docker create ardour:latest)
docker cp "$CONTAINER_ID":/build/out .
docker rm -f "$CONTAINER_ID"
