#!/bin/bash


arch=$(uname -m)

WORKING_DIR="$(mktemp -d)"
trap 'rm -rf "$WORKING_DIR"' EXIT

pushd $WORKING_DIR > /dev/null

case "$OSTYPE" in
  darwin*)
    OSTYPE="darwin"
    ;;
  linux-gnu*)
    OSTYPE="linux-gnu"
    ;;
  *)
    >&2 echo "Unsupported OS '$OSTYPE'. Exiting..."
    exit 0
    ;;
esac

tarball=dk-${OSTYPE}-${arch}.tar.gz
curl -sS -L -o "$tarball" "https://github.com/hq6/dk/releases/latest/download/${tarball}"
tar xf $tarball
FROM_RELEASE=true bin/install.sh

popd
