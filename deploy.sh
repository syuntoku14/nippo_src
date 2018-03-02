#!/usr/bin/env bash
set -e
cd build
git add .
git commit -m "$(shell date +'%F %R:%S')"
git push origin master
