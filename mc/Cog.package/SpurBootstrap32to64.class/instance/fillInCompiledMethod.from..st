bootstrap image
fillInCompiledMethod: obj64 from: obj32
	| offset |
	0 to: (heap32 numPointerSlotsOf: obj32) - 1 do:
		[:i|
		 heap64
			storePointerUnchecked: i
			ofObject: obj64
			withValue: (self map32BitOop: (heap32 fetchPointer: i ofObject: obj32))].
	offset := (interpreter64 startPCOfMethod: obj64)
			- (interpreter32 startPCOfMethod: obj32).
	(interpreter32 startPCOfMethod: obj32)
		to: (heap32 numBytesOf: obj32) - 1
		do: [:i|
			heap64
				storeByte: offset + i 
				ofObject: obj64
				withValue: (heap32 fetchByte: i ofObject: obj32)]