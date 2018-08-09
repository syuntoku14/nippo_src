#!/usr/bin/env bash
set -euxo pipefail
cd build
git add .
git commit -m "$(date +'%F %R:%S')" || true
git push origin master
