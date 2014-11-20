bootstrap image
incrementPCField: fieldIndex ofObject: obj64 for: method32
	| value nLits |
	value := heap64 fetchPointer: fieldIndex ofObject: obj64.
	(heap64 isIntegerObject: value)
		ifTrue:
			[nLits := heap32 literalCountOf: method32.
			 heap64
				storePointerUnchecked: fieldIndex
				ofObject: obj64
				withValue: (heap64 integerObjectOf: nLits + LiteralStart * 4 + (heap64 integerValueOf: value))]
		ifFalse:
			[self assert: (reverseMap at: value) = heap32 nilObject]