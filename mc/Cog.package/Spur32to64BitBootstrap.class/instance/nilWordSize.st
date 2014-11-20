bootstrap image
nilWordSize
	| wordSizeSym |
	wordSizeSym := self findSymbol: #WordSize.
	heap64 allOldSpaceObjectsDo:
		[:o|
		((heap64 numSlotsOf: o) > ValueIndex
		and: [(heap64 isPointersNonImm: o)
		and: [(heap64 fetchPointer: KeyIndex ofObject: o) = wordSizeSym
		and: [(heap64 fetchPointer: ValueIndex ofObject: o) = (heap64 integerObjectOf: 4)]]]) ifTrue:
			[heap64 storePointer: ValueIndex ofObject: o withValue: heap64 nilObject]]