#!/bin/bash -e

. ./buildpack_vars.sh

echo "Buildpack name: $NAME"
echo "Source directory: $SRC_DIR"
echo "Target file: $ZIP_FILE"

pushd ${SRC_DIR}
  rm -f "$ZIP_FILE"
  zip -r "$ZIP_FILE" bin lib
popd