#!/bin/bash

wget -O- get.pharo.org/20+vm | bash

echo -e "LOADING VM MAKER SOURCES INTO IMAGE"
echo -e "./pharo Pharo.image ../codegen-scripts/LoadVMMaker.st"
./pharo Pharo.image ../codegen-scripts/LoadVMMaker.st
