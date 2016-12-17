bootstrap image
cloneFreeLists: oldObj
	| newObj |
	newObj := newHeap
				allocateSlots: newHeap numFreeLists
				format: newHeap wordIndexableFormat
				classIndex: newHeap wordSizeClassIndexPun.
	reverseMap at: newObj put: oldObj.
	^map at: oldObj put: newObj