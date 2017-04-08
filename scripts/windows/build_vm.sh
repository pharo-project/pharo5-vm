#!/usr/bin/env bash
set -eu

. scripts/windows/config.sh

cd opensmalltalk-vm
./.travis_build.sh