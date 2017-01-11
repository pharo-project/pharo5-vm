# Deploy in appveyor environment

# deploy if repository is pharo-project/pharo-vm
if [ "$APPVEYOR_REPO_NAME" != "pharo-project/pharo-vm" ]; then
	echo "Trying to deploy in repository: $APPVEYOR_REPO_NAME. Skipping."
	exit 
fi

# deploy on master branch
if [ "$APPVEYOR_REPO_BRANCH" != "master" ]; then
	echo "Trying to deploy in branch: $APPVEYOR_REPO_BRANCH. Skipping."
	exit 
fi

echo "Deploying to bintray with user: $BINTRAY_USER"
appveyor DownloadFile https://curl.haxx.se/ca/cacert.pem
export SSL_CERT_FILE=cacert.pem
gem install dpl
dpl --provider=bintray --user=$BINTRAY_USER --key=$BINTRAY_API_KEY --file=.bintray.json