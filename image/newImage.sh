#!/bin/bash

PREBUILT_IMAGE_URL="https://ci.lille.inria.fr/pharo/view/VM-dev/job/Cog%20Git%20Tracker%20(cog-osx)/lastSuccessfulBuild/artifact/vmmaker-image.zip"

URL="https://ci.lille.inria.fr/pharo/view/Pharo%201.4/job/Pharo%201.4/lastSuccessfulBuild/artifact/"
VERSION="Pharo-1.4"

# ----------------------------------------------------------------------------

openImage() {
    IMAGE=$1
    SCRIPT="$PWD/ConfigurationOfCog.st"

    echo 'OPENING IMAGE'
    echo "    $IMAGE"
    echo "    $SCRIPT"
   
    for vm in CogVM cog pharo squeak StackVM stackVM; do
        hash $vm 2>&-      && echo "using " `which ${vm}` \
            && $vm  "$IMAGE" "$SCRIPT"        && exit 0
    done  
   
    hash open 2>&-       && echo "using " `which open` \
        && open "$IMAGE" --args "$SCRIPT"   && exit 0
    
    hash gnome-open 2>&- && echo "using " `which gnome-open` \
        && gnome-open "$IMAGE"              && exit 0
}

# ----------------------------------------------------------------------------
echo "LOADING PREBUILT IMAGE"
echo "    $PREBUILT_IMAGE_URL"

curl "$PREBUILT_IMAGE_URL" -o "image.zip" && \
unzip image.zip && \ 
rm image.zip  && \
openImage "$PWD/generator.image" && exit 1


# ----------------------------------------------------------------------------
echo "FETCHING FRESH IMAGE"
echo "   $URL$VERSION.zip"

# using curl since that's installed by default on mac os x :/
curl "$URL$VERSION.zip" -o "image.zip"

# ----------------------------------------------------------------------------
echo "UNZIPPING"
echo "    $PWD/image.zip"

unzip image.zip && \
rm image.zip    && \
mv $VERSION/*  .   && \
rm -rf $VERSION    || exit 1


# ----------------------------------------------------------------------------
# try to open the image...
openImage "$PWD/$VERSION.image"

