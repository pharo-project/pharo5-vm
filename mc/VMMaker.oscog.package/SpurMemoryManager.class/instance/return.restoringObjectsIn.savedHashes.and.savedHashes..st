image segment in/out
return: errCode restoringObjectsIn: firstArray savedHashes: firstSavedHashes and: secondArray savedHashes: secondSavedHashes
	self restoreObjectsIn: firstArray savedHashes: firstSavedHashes.
	self restoreObjectsIn: secondArray savedHashes: secondSavedHashes.
	self leakCheckImageSegments ifTrue:
		[self runLeakCheckerForFullGC: true].
	self assert: self allObjectsUnmarked.
	^errCode