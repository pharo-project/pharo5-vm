#!/bin/bash
set -e


# This really needs bash as otherwise the \n will be expanded too.

cd opensmalltalk-vm
echo "`cat platforms/Cross/vm/sqSCCSVersion.h | .git_filters/RevDateURL.smudge`" > platforms/Cross/vm/sqSCCSVersion.h
echo "`cat platforms/Cross/plugins/sqPluginsSCCSVersion.h | .git_filters/RevDateURL.smudge`" > platforms/Cross/plugins/sqPluginsSCCSVersion.h
