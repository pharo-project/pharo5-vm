#! /bin/bash
# this script will amend current commit by adding generated sources, so we do not need to regenerate them 
# in case of debugging. 
# Required environment variables:
# 	
#  	GIT_USERNAME - the git user.name property
# 	GIT_USERMAIL - the git user.email property
# 
# This script requires ./deploy-key.sh
# This script needs to be executed on ./scripts subdirectory 

set -ex

if [  "$TRAVIS_REPO_SLUG" != "estebanlm/pharo-vm" -o "$TRAVIS_BRANCH" != "master" ]; then
	exit
fi

#if [ "$TRAVIS_COMMIT" != "`git rev-parse HEAD`" ]; then
#	echo "Not in HEAD, aborting."
#	exit 
#fi

# prepare keys (I will use same as deploy, so I just install them now)
./deploy-key.sh
# set system properties
git config user.name "\"$GIT_USERNAME\""
git config user.email "\"$GIT_USERMAIL\""
# stage changes
git add ../opensmalltalk-vm/src/*
git add ../opensmalltalk-vm/spursrc/*
git add ../opensmalltalk-vm/spur64src/*
# commit & push
git commit --amend --no-edit
git push