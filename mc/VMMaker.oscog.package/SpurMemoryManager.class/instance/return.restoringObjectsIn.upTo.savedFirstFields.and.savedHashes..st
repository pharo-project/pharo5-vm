image segment in/out
return: errCode restoringObjectsIn: firstArray upTo: limitOrTag savedFirstFields: savedFirstFields and: secondArray savedHashes: secondSavedHashes
	"This is part of storeImageSegmentInto:outPointers:roots:."
	self restoreObjectsIn: firstArray upTo: limitOrTag savedFirstFields: savedFirstFields.
	self restoreObjectsIn: secondArray savedHashes: secondSavedHashes.
	self runLeakCheckerFor: GCModeImageSegment.
	self assert: self allObjectsUnmarked.
	^errCode