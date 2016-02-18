bootstrap image
clone: oldObj classIndex: classIndex
	| newObj format numBytes |
	((format := oldHeap formatOf: oldObj) >= oldHeap firstLongFormat
	 and: [numBytes := oldHeap numBytesOf: oldObj.
		format >= oldHeap firstCompiledMethodFormat
		and: [(oldInterpreter primitiveIndexOf: oldObj) > 0]]) ifTrue:
			[numBytes := numBytes + 3].
	newObj := newHeap
				allocateSlots: (format >= oldHeap firstLongFormat
								ifTrue: [newHeap numSlotsForBytes: numBytes]
								ifFalse: [oldHeap numSlotsOf: oldObj])
				format: (self newFormatFor: oldObj numBytes: numBytes)
				classIndex: classIndex.
	reverseMap at: newObj put: oldObj.
	^map at: oldObj put: newObj