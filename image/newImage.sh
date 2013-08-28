#!/bin/bash

NO_COLOR='\033[0m' #disable any colors
YELLOW='\033[0;33m'

WGET_CERTCHECK="--no-check-certificate"
# on macs wget is pretty old and not recognizing this option 
wget --help | grep -- "$WGET_CERTCHECK" 2>&1 > /dev/null || WGET_CERTCHECK=''

# ----------------------------------------------------------------------------

echo -e "${YELLOW}LOADING STABLE 2.0 IMAGE AND VM" $NO_COLOR

echo -e "wget -O- $WGET_CERTCHECK get.pharo.org/20+vm | bash"
wget -O- $WGET_CERTCHECK get.pharo.org/20+vm | bash

echo -e "${YELLOW}LOADING VM MAKER SOURCES INTO IMAGE" $NO_COLOR
echo -e "./pharo Pharo.image ../codegen-scripts/LoadVMMaker.st"
./pharo Pharo.image ../codegen-scripts/LoadVMMaker.st