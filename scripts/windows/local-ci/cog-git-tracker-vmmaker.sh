#!/bin/bash

#
# Preparation of the common artefacts for building the various flavors of
# Pharo VMs downstream
#

# clone in cog folder, to avoid conflict with pharo-vm when we download a vm which in fact contains that already.
git clone https://github.com/pharo-project/pharo-vm.git cog
git --version
cd cog
git reset --hard HEAD
# git clean --force -d
mkdir -p build
scripts/extract-commit-info.sh
cd ..
tar czf cog.tar.gz --exclude=cog/.git cog/
cd cog/image
./newImage.sh
# Let's perform some housekeeping removing pharovm executables and stuff
# In fact, it is not really needed to rm the files as the zip isn't using any special stuff
#rm -Rf pharo-vm
#rm -f pharo pharo-ui vm.sh vm-ui.sh
# Pack the artefacts that are going to be used downstream for all kinds
# of builds (e.g. Win, OSX, Linux...)
cp pharo-vm/*.sources .
zip vmmaker-image.zip generator.changes generator.image *.sources
mv vmmaker-image.zip ../..

