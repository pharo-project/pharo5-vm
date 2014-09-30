patching
patchAndUploadUnpatchedInTrunk
	"Look for unbranched versions in the default repository that are newer than the
	 latest patched versions there-in. Download and patch them and upload the patched
	 versions."
	"(SpurBootstrapMonticelloPackagePatcher new
		from: 'spurpackages'
		to: 'trunkpackages')
			patchAndUploadUnpatchedInTrunk"
	| trunk sourceRepo |
	sourceDir assureExistence; deleteLocalFiles.
	destDir assureExistence; deleteLocalFiles.
	sourceRepo := MCDirectoryRepository directory: sourceDir.
	(trunk := self trunk) cacheAllFileNamesDuring:
		[| latestBranches latestUnbranched |
		latestBranches := self packagesAndPatches keys collect:
							[:package|
							(trunk versionNamesForPackageNamed: package name, '.spur') detectMax: [:vn | vn asMCVersionName versionNumber]].
		latestUnbranched := latestBranches collect: [:verName| (verName copyReplaceAll: '.spur' with: '') asMCVersionName].
		(trunk possiblyNewerVersionsOfAnyOf: latestUnbranched) do:
			[:unpatched|
			sourceRepo storeVersion: (trunk versionNamed: unpatched)].
		 self patchAsNeeded.
		 self uploadFrom: (MCDirectoryRepository directory: destDir) to: trunk]