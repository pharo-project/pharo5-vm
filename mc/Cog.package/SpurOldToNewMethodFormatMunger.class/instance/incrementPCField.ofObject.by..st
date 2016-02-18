munging
incrementPCField: fieldIndex ofObject: newObj by: n
	| value |
	value := heap fetchPointer: fieldIndex ofObject: newObj.
	(heap isIntegerObject: value)
		ifTrue:
			[heap
				storePointerUnchecked: fieldIndex
				ofObject: newObj
				withValue: (heap integerObjectOf: n + (heap integerValueOf: value))]
		ifFalse:
			[self assert: value = heap nilObject]