patching
patchAsNeeded
	(sourceDir exists and: [destDir exists]) ifFalse:
		[self error: 'one or both of the directories don''t exist'].
	self packagesAndPatches keysAndValuesDo:
		[:package :patches|
		 (self filesForPackage: package in: sourceDir) do:
			[:packageFile| | spurPackageFile |
			 spurPackageFile := self spurBranchNameForInfo: packageFile package: package.
			 ((destDir includesKey: packageFile) or: [destDir includesKey: spurPackageFile])
				ifTrue:
					[Transcript
						cr; nextPutAll: destDir fullName; nextPutAll: ' contains either ';
						nextPutAll: packageFile; nextPutAll: ' or '; nextPutAll: spurPackageFile;
						nextPutAll: '; not saving'; flush]
				ifFalse:
					[self patchPackage: packageFile with: patches for: package]]]

	"| patcher |
	 patcher := SpurBootstrapMonticelloPackagePatcher new
					from: 'trunkpackages'
					to: 'spurpackages'.
	patcher trunk cacheAllFileNamesDuring:
		[patcher patchAsNeeded]"