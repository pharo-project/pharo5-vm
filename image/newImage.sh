#!/bin/bash
URL="https://ci.lille.inria.fr/pharo/view/Pharo%201.4/job/Pharo%201.4/lastSuccessfulBuild/artifact/"
VERSION="Pharo-1.4"
# using curl since that's installed by default on mach :/
curl "$URL$VERSION.zip" -o "$VERSION.zip"

unzip $VERSION.zip && \
rm $VERSION.zip    && \
mv $VERSION/*  .   && \
rm -rf $VERSION    || exit 1


# try to open the image...
IMAGE="$PWD/$VERSION.image"
SCRIPT="$PWD/ConfigurationOfCog.st"

hash pharo 2>&-      && pharo  "$IMAGE" "$SCRIPT" && exit 0
hash squeak 2>-      && squeak "$IMAGE" "$SCRIPT" && exit 0

hash open 2>&-       && open "$IMAGE" --args "$SCRIPT"      && exit 0
hash gnome-open 2>&- && gnome-open "$IMAGE" && exit 0
