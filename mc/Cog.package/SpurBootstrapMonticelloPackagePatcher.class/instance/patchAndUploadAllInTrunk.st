patching
patchAndUploadAllInTrunk
	"Look for all versions in the default repository that have patched versions there-in.
	 Download and patch them and upload the patched versions (overwriting the older ones)."
	"(SpurBootstrapMonticelloPackagePatcher new
		from: 'trunkpackages'
		to: 'spurpackages')
			patchAndUploadAllInTrunk"
	| seed trunk sourceRepo cacheRepo |
	seed := 'Are you really sure you want to do this?\It should happen only once!' withCRs.
	3 timesRepeat:
		[(UIManager confirm: seed) ifFalse: [^self].
		 seed := seed copyReplaceAll: 'really ' with: 'really, really '].
	sourceDir assureExistence; deleteLocalFiles.
	destDir assureExistence; deleteLocalFiles.
	sourceRepo := MCDirectoryRepository directory: sourceDir.
	cacheRepo := MCCacheRepository default.
	(trunk := self trunk) cacheAllFileNamesDuring:
		[| latestBranches latestUnbranched |
		latestBranches := self packages collect:
							[:package|
							(trunk versionNamesForPackageNamed: package name, '.spur') detectMin: [:vn | vn asMCVersionName versionNumber]].
		latestUnbranched := latestBranches collect:
								[:verName|
								(trunk versionNamed: (verName copyReplaceAll: '.spur' with: '') asMCVersionName) info ancestors first versionName].
		((trunk possiblyNewerVersionsOfAnyOf: latestUnbranched)
			reject: [:unpatched| unpatched includesSubString: '.spur'])
			do: [:unpatched|
				"it is claimed that whether a repository contains a .mcz or a .mcd is irrelevant.  At least for the cache repository that's not true."
				sourceRepo storeVersion: (self cachedNonDiffyVersionNamed: unpatched from: trunk)].
		 self patchAsNeeded.
		 self uploadFrom: (MCDirectoryRepository directory: destDir) to: trunk]