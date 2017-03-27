#! /bin/bash

set -ex

if [  "$TRAVIS_REPO_SLUG" != "estebanlm/pharo-vm" -o "$TRAVIS_BRANCH" != "master" ]; then
	exit
fi

LAST_MESSAGE=`git log -1 --pretty=%B`

git add opensmalltalk-vm/src/*
git add opensmalltalk-vm/spursrc/*
git add opensmalltalk-vm/spur64src/*

git commit --amend -m "$LAST_MESSAGE"
