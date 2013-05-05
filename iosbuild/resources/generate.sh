#!/bin/bash

# getting right pharo
wget --quiet -qO - http://files.pharo.org/script/ciPharo14PharoVM.sh | bash

# preparing for iPhone
./vm.sh Pharo.image buildImage.st