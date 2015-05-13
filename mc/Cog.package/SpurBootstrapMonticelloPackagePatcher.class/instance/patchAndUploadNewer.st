patching
patchAndUploadNewer
	"Look for unbranched versions on the default repository that are newer than the
	 image''s versions. Download and patch them and upload the patched versions."
	"(SpurBootstrapMonticelloPackagePatcher new
		from: 'trunkpackages'
		to: 'spurpackages')
			patchAndUploadNewer"
	| repo sourceRepo |
	sourceDir deleteLocalFiles.
	destDir deleteLocalFiles.
	repo := self repositoryForUrl: MCMcmUpdater defaultUpdateURL.
	sourceRepo := MCDirectoryRepository directory: sourceDir.
	repo cacheAllFileNamesDuring:
		[self packages do:
			[:package| | workingCopy |
			workingCopy := MCWorkingCopy allManagers detect: [:pkg| pkg packageName = package packageName].
			(workingCopy possiblyNewerVersionsIn: repo) do:
				[:newerVersion|
				 newerVersion packageAndBranchName = package packageName ifTrue: "Don't patch already patched packages!!"
					[(sourceRepo includesVersionNamed: newerVersion) ifFalse:
						[sourceRepo storeVersion: (repo versionNamed: newerVersion)]]]].
		 self patchAsNeeded.
		 self uploadFrom: (MCDirectoryRepository directory: destDir) to: repo]