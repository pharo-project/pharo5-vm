patching
patchAsNeeded
	(sourceDir exists and: [destDir exists]) ifFalse:
		[self error: 'one or both of the directories don''t exist'].
	self packagesAndPatches keysAndValuesDo:
		[:package :patches|
		 (self filesForPackage: package in: sourceDir) do:
			[:packageFile|
			 (destDir includesKey: packageFile) ifFalse:
				[self patchPackage: packageFile with: patches for: package]]]