bootstrap image
installSmallFloatInClassTable
	| firstPage smallFloatClass |
	firstPage := heap64 fetchPointer: 0 ofObject: heap64 classTableRootObj.
	smallFloatClass := self smallFloatClass.
	self assert: (heap64 hashBitsOf: smallFloatClass) = 0.
	heap64
		storePointer: heap64 smallFloatTag
		ofObject: firstPage
		withValue: smallFloatClass.
	heap64
		setHashBitsOf: smallFloatClass to: heap64 smallFloatTag