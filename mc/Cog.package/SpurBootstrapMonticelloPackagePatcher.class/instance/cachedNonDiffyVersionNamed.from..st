patching
cachedNonDiffyVersionNamed: versionName from: repo
	"Make sure that the cache contains a non-diffy version of versionName and  answer it."
	| cacheRepo nonDiffyVersion |
	self assert: (versionName endsWith: '.mcz').
	cacheRepo := MCCacheRepository default.
	"Make sure that at least the diffy (.mcd) version is present"
	(cacheRepo directory includesKey: versionName) ifFalse:
		[cacheRepo storeVersion: (repo versionNamed: versionName)].
	"if after storeVersion there's still no .mcz we need to create one; sigh..."
	(cacheRepo directory includesKey: versionName) ifFalse:
		[| baseName diffyVersionName diffyVersion file delete |
		 baseName := versionName allButLast: 4. "strip .mcz"
		 diffyVersionName := cacheRepo directory fileNames detect: [:fn| (fn endsWith: '.mcd') and: [(fn copyUpTo: $() = baseName]].
		 diffyVersion := cacheRepo versionNamed: diffyVersionName.
		 file := cacheRepo directory newFileNamed: versionName.
		 delete := false.
		 [file binary.
		  [MCMczWriter fileOut: diffyVersion on: file]
			on: Error
			do: [:ex|
				delete := true. "don't leave half-formed .mcz files around to screw things up later on..."
				ex pass]]
			ensure:
				[file close.
				 delete ifTrue:
					[cacheRepo directory deleteFileNamed: versionName]].
		 "now delete the damn diffy version that caused all the pain in the first place"
		 delete ifFalse:
			[cacheRepo directory deleteFileNamed: diffyVersionName].
		 cacheRepo flushCache; cacheAllFilenames].
	nonDiffyVersion := cacheRepo versionNamed: versionName.
	self assert: (nonDiffyVersion fileName endsWith: '.mcz').
	^nonDiffyVersion