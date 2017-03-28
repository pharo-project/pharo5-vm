#! /bin/bash

set -ex

if [  "$TRAVIS_REPO_SLUG" != "estebanlm/pharo-vm" -o "$TRAVIS_BRANCH" != "master" ]; then
	exit
fi

# prepare keys (I will use same as deploy, so I just install them now)
./deploy-key.sh
# set system properties
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_USERMAIL"

#LAST_MESSAGE=`git log -1 --pretty=%B`

git add ../opensmalltalk-vm/src/*
git add ../opensmalltalk-vm/spursrc/*
git add ../opensmalltalk-vm/spur64src/*

git commit --amend --no-edit

#-m "$LAST_MESSAGE"
