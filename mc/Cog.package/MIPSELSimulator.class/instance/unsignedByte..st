memory
unsignedByte: address
	address < readableBase ifTrue: [self readFault: address].
	address > readableLimit ifTrue: [self readFault: address].
	^memory byteAt: address + 1