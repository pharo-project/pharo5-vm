bootstrap image
ensureSmallFloatInClassTable
	| firstClassTablePage smallFloatClass |
	firstClassTablePage := heap64 fetchPointer: 0 ofObject: heap64 classTableRootObj.
	smallFloatClass := self smallFloatClass.
	(heap64 hashBitsOf: smallFloatClass) = heap64 smallFloatTag
		ifTrue:
			[self assert: (heap64 fetchPointer: heap64 smallFloatTag ofObject: firstClassTablePage)
						= smallFloatClass]
		ifFalse:
			[self assert: (heap64 hashBitsOf: smallFloatClass) = 0.
			 heap64
				storePointer: heap64 smallFloatTag ofObject: firstClassTablePage withValue: smallFloatClass;
				setHashBitsOf: smallFloatClass to: heap64 smallFloatTag]