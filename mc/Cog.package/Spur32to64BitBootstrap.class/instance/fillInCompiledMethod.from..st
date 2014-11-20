bootstrap image
fillInCompiledMethod: obj64 from: obj32
	| offset |
	"interpreter32 printOop: oop32"
	"interpreter64 printOop: oop64"
	0 to: (heap32 numPointerSlotsOf: obj32) - 1 do:
		[:i| | oop32 oop64 |
		 oop32 := heap32 fetchPointer: i ofObject: obj32.
		 oop64 := self map32BitOop: oop32.
		 heap64
			storePointerUnchecked: i
			ofObject: obj64
			withValue: oop64.
		 (heap64 isIntegerObject: oop64) ifTrue:
			[interpreter32 initPrimCall.
			 self assert: (interpreter32 signed64BitValueOf: oop32) = (heap64 integerValueOf: oop64)]].
	offset := (interpreter64 startPCOfMethod: obj64)
			- (interpreter32 startPCOfMethod: obj32).
	(interpreter32 startPCOfMethod: obj32)
		to: (heap32 numBytesOf: obj32) - 1
		do: [:j|
			heap64
				storeByte: offset + j 
				ofObject: obj64
				withValue: (heap32 fetchByte: j ofObject: obj32)]