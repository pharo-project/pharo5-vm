#!/bin/bash

# getting right pharo
wget -O- get.pharo.org/14+vm | bash

# preparing for iPhone
./pharo Pharo.image buildImage.st