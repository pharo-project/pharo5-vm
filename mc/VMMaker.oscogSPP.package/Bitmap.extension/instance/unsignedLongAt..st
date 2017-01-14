*VMMaker-JITSimulation
unsignedLongAt: byteIndex
	"Compatiblity with the ByteArray & Alien methods of the same name."
	^(byteIndex - 1 bitAnd: 3) = 0
		ifTrue: [self at: byteIndex - 1 // 4 + 1]
		ifFalse: [self unsignedLongAt: byteIndex bigEndian: true]