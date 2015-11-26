memory
unsignedByte: address put: value
	address < writableBase ifTrue: [self writeFault: address].
	address > writableLimit ifTrue: [self writeFault: address].
	^memory byteAt: address + 1 put: value