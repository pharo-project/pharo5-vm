#!/bin/bash

# getting right pharo
wget -O- get.pharo.org/14+vm | bash

# preparing for iPhone
./pharo Pharo.image buildImage.st

# ensure PharoV10.source in the place I need it
cp ./pharo-vm/PharoV10.sources .