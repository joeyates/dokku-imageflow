#!/usr/bin/env bash

set -euxo pipefail

sudo chown -R imageflow /home/imageflow/images

/home/imageflow/imageflow_server start --bind-address 0.0.0.0 --port 3000 --data-dir /home/imageflow/data/ --mount /images/:ir4_local:/home/imageflow/images/
