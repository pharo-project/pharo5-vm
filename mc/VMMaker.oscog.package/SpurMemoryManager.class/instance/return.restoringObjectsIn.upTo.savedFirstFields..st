image segment in/out
return: errCode restoringObjectsIn: firstArray upTo: limitOrTag savedFirstFields: savedFirstFields
	<inline: false>
	"This is part of storeImageSegmentInto:outPointers:roots:."
	self cCode: [] inSmalltalk: [errCode ~= 0 ifTrue: [self halt]].
	self restoreObjectsIn: firstArray upTo: limitOrTag savedFirstFields: savedFirstFields.
	self runLeakCheckerFor: GCModeImageSegment.
	self assert: self allObjectsUnmarked.
	^errCode