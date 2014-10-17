repository population
downloadToSourceDirAllPackageVersionsStartingWith: aMCVersionInfo from: repo 
	| localRepo priorName |
	priorName := MCVersionName on: (aMCVersionInfo versionName
											copyReplaceAll: aMCVersionInfo versionNumber asString
											with: (aMCVersionInfo versionNumber - 1) asString).
	localRepo := MCDirectoryRepository directory: sourceDir.
	(repo possiblyNewerVersionsOfAnyOf: {priorName asMCVersionName}) do:
		[:newerVersion | 
		(localRepo includesVersionNamed: newerVersion) ifFalse:
			[localRepo storeVersion: (repo versionNamed: newerVersion)]]