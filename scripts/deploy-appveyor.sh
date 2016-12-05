# Deploy in appveyor environment

# deploy if repository is pharo-project/pharo-vm
if [ "$APPVEYOR_REPO_NAME" != "pharo-project/pharo-vm" ]; then
	exit 
fi

# deploy on master branch
if [ "$APPVEYOR_REPO_BRANCH" != "master" ]; then
	exit 
fi

appveyor DownloadFile https://curl.haxx.se/ca/cacert.pem
export SSL_CERT_FILE=cacert.pem
gem install dpl
dpl --provider=bintray --user=$BINTRAY_USER --key=$BINTRAY_API_KEY --file=.bintray.json