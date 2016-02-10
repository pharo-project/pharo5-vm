#!/bin/bash
wget --quiet files.pharo.org/vm/src/vmmaker-image.zip
wget --quiet files.pharo.org/vm/src/cog.tar.gz
tar -xzf cog.tar.gz
mkdir -p cog/build
mkdir -p cog/image
cd cog/image
unzip -o ../../vmmaker-image.zip
wget -O- get.pharo.org/vm30 | bash
./pharo generator.image eval 'PharoVMBuilder buildOnJenkins: '\''win'\'''
cd ../../
tar -czf sources.tar.gz -C cog .
cd cog/build
sh build.sh
