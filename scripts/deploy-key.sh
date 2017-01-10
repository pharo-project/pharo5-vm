#! /bin/bash

set -e

openssl aes-256-cbc -K $DEPLOY_KEY -iv $DEPLOY_KEY_IV -in deploy_key.enc -out ~/.ssh/id_rsa -d
chmod 600 ~/.ssh/id_rsa

echo "Host files.pharo.org
	User $DEPLOY_USER
	ProxyCommand ssh $DEPLOY_USER@sesi-ssh.inria.fr \"nc file-pharo.inria.fr %p 2> /dev/null\"" >> ~/.ssh/config

ssh-keyscan -H sesi-ssh.inria.fr >> ~/.ssh/known_hosts