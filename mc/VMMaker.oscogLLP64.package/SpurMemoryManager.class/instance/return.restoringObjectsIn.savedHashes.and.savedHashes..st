image segment in/out
return: errCode restoringObjectsIn: firstArray savedHashes: firstSavedHashes and: secondArray savedHashes: secondSavedHashes
	"This is part of storeImageSegmentInto:outPointers:roots:."
	self restoreObjectsIn: firstArray savedHashes: firstSavedHashes.
	self restoreObjectsIn: secondArray savedHashes: secondSavedHashes.
	self runLeakCheckerFor: GCModeImageSegment.
	self assert: self allObjectsUnmarked.
	^errCode