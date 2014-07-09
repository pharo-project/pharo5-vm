bootstrap image
clone: oldObj classIndex: classIndex
	| newObj |
	newObj := newHeap
				allocateSlots: (oldHeap fetchWordLengthOf: oldObj)
				format: (self newFormatFor: oldObj)
				classIndex: classIndex.
	reverseMap at: newObj put: oldObj.
	^map at: oldObj put: newObj