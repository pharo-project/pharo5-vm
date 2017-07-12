image segment in/out
return: errCode restoringObjectsIn: firstArray savedFirstFields: savedFirstFields and: secondArray savedHashes: savedHashes
	<inline: false>
	"This is part of storeImageSegmentInto:outPointers:roots:."
	self cCode: [] inSmalltalk: [errCode ~= 0 ifTrue: [self halt]].
	self restoreObjectsIn: firstArray upTo: -1 savedFirstFields: savedFirstFields.
	self restoreObjectsIn: secondArray savedHashes: savedHashes.
	self runLeakCheckerFor: GCModeImageSegment.
	self assert: self allObjectsUnmarked.
	^errCode