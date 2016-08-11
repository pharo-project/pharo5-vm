#is_pull_request=${TRAVIS_PULL_REQUEST:-${APPVEYOR_PULL_REQUEST_NUMBER:-false}}
#branch=${TRAVIS_BRANCH:-${APPVEYOR_REPO_BRANCH}}

is_pull_request=false
if [[ $is_pull_request == "false" ]]; then
    echo "`cat .bintray.json | opensmalltalk-vm/.git_filters/RevDateURL.smudge`" > .bintray.json
    sed -i.bak 's/$Rev: \([0-9][0-9]*\) \$/\1/' .bintray.json
    sed -i.bak 's/$Date: \(.*\) \$/\1/' .bintray.json
    rm -f .bintray.json.bak
fi