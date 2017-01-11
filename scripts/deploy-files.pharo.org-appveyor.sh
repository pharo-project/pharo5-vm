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

sh `dirname $0`/deploy-files.pharo.org.sh