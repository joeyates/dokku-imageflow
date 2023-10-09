#!/usr/bin/env bash

set -euxo pipefail

echo "Running imageflow_server"

/home/imageflow/imageflow_server start \
  --bind-address 0.0.0.0 \
  --port $IMAGEFLOW_PORT \
  --data-dir /home/imageflow/data/ \
  --mount /$IMAGEFLOW_PATH_PREFIX:ir4_local:/home/imageflow/images/
