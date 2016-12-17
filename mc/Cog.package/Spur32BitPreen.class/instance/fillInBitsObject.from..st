bootstrap image
fillInBitsObject: obj64 from: obj32
	0 to: (oldHeap numBytesOf: obj32) - 1 do:
		[:i|
		newHeap
			storeByte: i
			ofObject: obj64
			withValue: (oldHeap fetchByte: i ofObject: obj32)]