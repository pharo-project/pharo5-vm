bootstrap image
fillInPointerObject: obj64 from: obj32 
	0 to: (heap64 numSlotsOf: obj64) - 1 do:
		[:i|
		 heap64
			storePointerUnchecked: i
			ofObject: obj64
			withValue: (self map32BitOop: (heap32 fetchPointer: i ofObject: obj32))]