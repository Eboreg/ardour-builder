#!/usr/bin/env bash

set -e

# ROOT_DIR="$( cd "$( dirname "$0" )" && pwd )"
# BUILD_DIR="$ROOT_DIR/build"
# ENV_DIR="$BUILD_DIR/env"
# SOURCE_DIR="$BUILD_DIR/sources"

# mkdir -p "$SOURCE_DIR"
# echo "Downloading sources to $SOURCE_DIR..."

# for ENV_FILE in "$ENV_DIR"/*; do
#     # shellcheck disable=SC1091
#     . "$BUILD_DIR/set-env-vars.sh" "$ENV_FILE"
#     ARCHIVE_PATH="$SOURCE_DIR/$ARCHIVE_NAME"
#
#     if [ -n "$DOWNLOAD_URL" ] && [ ! -f "$ARCHIVE_PATH" ]; then
#         echo "Downloading $DOWNLOAD_URL to $ARCHIVE_PATH"
#         curl -L "$DOWNLOAD_URL" -o "$ARCHIVE_PATH"
#     fi
# done

docker build . -t ardour --progress plain
CONTAINER_ID=$(docker create ardour:latest)
docker cp "$CONTAINER_ID":/build/out .
docker rm -f "$CONTAINER_ID"
