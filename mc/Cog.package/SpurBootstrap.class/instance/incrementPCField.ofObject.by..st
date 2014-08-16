bootstrap image
incrementPCField: fieldIndex ofObject: newObj by: n
	| value |
	value := newHeap fetchPointer: fieldIndex ofObject: newObj.
	(newHeap isIntegerObject: value)
		ifTrue:
			[newHeap
				storePointerUnchecked: fieldIndex
				ofObject: newObj
				withValue: (newHeap integerObjectOf: n + (newHeap integerValueOf: value))]
		ifFalse:
			[self assert: value = newHeap nilObject]