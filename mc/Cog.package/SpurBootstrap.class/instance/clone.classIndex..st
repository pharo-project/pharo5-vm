bootstrap image
clone: oldObj classIndex: classIndex
	| newObj |
	newObj := newHeap
				allocateSlots: (((oldHeap isCompiledMethod: oldObj) and: [(oldInterpreter primitiveIndexOf: oldObj) > 0])
								ifTrue: [(oldHeap byteSizeOf: oldObj) + 3 + self wordSize - 1 // self wordSize]
								ifFalse: [oldHeap numSlotsOf: oldObj])
				format: (self newFormatFor: oldObj)
				classIndex: classIndex.
	reverseMap at: newObj put: oldObj.
	^map at: oldObj put: newObj