bootstrap image
fillInBitsObject: obj64 from: obj32
	0 to: (heap32 numBytesOf: obj32) - 1 do:
		[:i|
		heap64
			storeByte: i
			ofObject: obj64
			withValue: (heap32 fetchByte: i ofObject: obj32)]