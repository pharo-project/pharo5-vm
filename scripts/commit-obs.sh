#!/bin/bash

set -eu

if [ "${TRAVIS_BRANCH}" != "master" ]; then
    echo "Only pushing changes on master and not ${TRAVIS_BRANCH}"
    exit 0
fi

cat <<- EOF > ~/.oscrc
[general]
apiurl = https://api.opensuse.org
use_keyring = 0

[https://api.opensuse.org]
user = ${OBS_USER}
pass = ${OBS_PASS}
EOF

OBS_PACKAGE="pharo5"

OBS_HOME="devel:languages:pharo:latest"

# the project is always created via web or cli
osc co ${OBS_HOME} ${OBS_PACKAGE}

pushd .
# rm files if directory is not empty
cd ${OBS_HOME}/${OBS_PACKAGE}
if [ `ls | wc -l` != 0 ]; then
    osc rm *.dsc
    osc rm *.tar.*
fi
popd

# copy our new files and send them to obs
cp packaging/pharo5-vm-*.dsc packaging/pharo5-vm-*.tar.* ${OBS_HOME}/${OBS_PACKAGE}
cd ${OBS_HOME}/${OBS_PACKAGE}
osc add *.dsc *.tar.*
osc ci -v -m "new build ${TRAVIS_COMMIT_RANGE}"
