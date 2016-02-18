bootstrap
fillInBitsObject: newObj from: oldObj
	0 to: (oldHeap numSlotsOf: oldObj) - 1 do:
		[:i|
		newHeap
			storeLong32: i
			ofObject: newObj
			withValue: (oldHeap fetchLong32: i ofObject: oldObj)]