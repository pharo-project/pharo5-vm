bootstrap image
incrementPCField: fieldIndex ofObject: obj64 for: method32
	| value nLits |
	value := newHeap fetchPointer: fieldIndex ofObject: obj64.
	(newHeap isIntegerObject: value)
		ifTrue:
			[nLits := oldHeap literalCountOf: method32.
			 newHeap
				storePointerUnchecked: fieldIndex
				ofObject: obj64
				withValue: (newHeap integerObjectOf: nLits + LiteralStart * 4 + (newHeap integerValueOf: value))]
		ifFalse:
			[self assert: (reverseMap at: value) = oldHeap nilObject]