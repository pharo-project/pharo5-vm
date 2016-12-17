bootstrap image
fillInPointerObject: newObj from: oldObj 
	0 to: (oldHeap numSlotsOf: oldObj) - 1 do:
		[:i|
		 newHeap
			storePointerUnchecked: i
			ofObject: newObj
			withValue: (self map32BitOop: (oldHeap fetchPointer: i ofObject: oldObj))]