memory
signedByte: address
	address < readableBase ifTrue: [self readFault: address].
	address > readableLimit ifTrue: [self readFault: address].
	^memory signedByteAt: address + 1