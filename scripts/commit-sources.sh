#! /bin/bash
# this script will amend current commit by adding generated sources, so we do not need to regenerate them 
# in case of debugging. 
# Required environment variables:
# 	
#	DEPLOY_KEY   	- The -K key (a phrase on hex)
# 	DEPLOY_KEY_IV   - The -iv key (a phrase on hex)
#  	GIT_USERNAME - the git user.name property
# 	GIT_USERMAIL - the git user.email property
# 
# This script requires ./deploy-key.sh
# This script needs to be executed on ./scripts subdirectory 

set -ex

if [  "$TRAVIS_REPO_SLUG" != "estebanlm/pharo-vm" -o "$TRAVIS_BRANCH" != "master" ]; then
	exit
fi

# prepare keys 
if [ ! -e ~/.shh ]; then
	mkdir -p ~/.ssh
fi
openssl aes-256-cbc -K $DEPLOY_KEY -iv $DEPLOY_KEY_IV -in commit_key.enc -out ~/.ssh/id_rsa -d
chmod 600 ~/.ssh/id_rsa
# set system properties
git config user.name "$GIT_USERNAME"
git config user.email "$GIT_USERMAIL"
git config push.default simple
# checkout branch
git checkout -f $TRAVIS_BRANCH
git pull git@github.com:$TRAVIS_REPO_SLUG.git $TRAVIS_BRANCH
# stage changes
git add ../opensmalltalk-vm/src/*
git add ../opensmalltalk-vm/spursrc/*
git add ../opensmalltalk-vm/spur64src/*
# commit & push
git commit --amend -m "`git log -1 --pretty=%B` [skip ci]"
git push -f git@github.com:$TRAVIS_REPO_SLUG.git $TRAVIS_BRANCH
# ensure clean of key
rm -Rf ~/.ssh