#! /bin/bash

openssl aes-256-cbc -K $DEPLOY_KEY -iv $DEPLOY_KEY_IV -in deploy_key.enc -out ~/.ssh/id_rsa -d
chmod 600 ~/.ssh/id_rsa