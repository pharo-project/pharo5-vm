bootstrap image
map32BitOop: obj32
	"oldInterpreter printOop: obj32"
	^map
		at: obj32
		ifAbsent:
			[(oldHeap isImmediateCharacter: obj32)
				ifTrue: [newHeap characterObjectOf: (oldHeap characterValueOf: obj32)]
				ifFalse: [newHeap integerObjectOf: (oldHeap integerValueOf: obj32)]]