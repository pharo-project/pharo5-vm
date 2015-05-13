patching
patchAndUploadUnpatchedInTrunk
	"Look for unbranched versions in the default repository that are newer than the
	 latest patched versions there-in. Download and patch them and upload the patched
	 versions."
	"(SpurBootstrapMonticelloPackagePatcher new
		from: 'trunkpackages'
		to: 'spurpackages')
			patchAndUploadUnpatchedInTrunk"
	| trunk sourceRepo cacheRepo |
	sourceDir assureExistence; deleteLocalFiles.
	destDir assureExistence; deleteLocalFiles.
	sourceRepo := MCDirectoryRepository directory: sourceDir.
	cacheRepo := MCCacheRepository default.
	(trunk := self trunk) cacheAllFileNamesDuring:
		[| latestBranches latestUnbranched |
		latestBranches := self packages collect:
							[:package|
							(trunk versionNamesForPackageNamed: package name, '.spur') detectMax: [:vn | vn asMCVersionName versionNumber]]
							thenSelect: [:branch| branch notNil].
		latestUnbranched := latestBranches collect: [:verName| (verName copyReplaceAll: '.spur' with: '') asMCVersionName].
		((trunk possiblyNewerVersionsOfAnyOf: latestUnbranched)
			reject: [:unpatched| unpatched includesSubString: '.spur'])
			do: [:unpatched|
				"it is claimed that whether a repository contains a .mcz or a .mcd is irrelevant.  At least for the cache repositoriy that's not true."
				sourceRepo storeVersion: (self cachedNonDiffyVersionNamed: unpatched from: trunk)].
		 self patchAsNeeded.
		 self uploadFrom: (MCDirectoryRepository directory: destDir) to: trunk]