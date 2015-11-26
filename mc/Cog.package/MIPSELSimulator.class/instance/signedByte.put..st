memory
signedByte: address put: value
	address < writableBase ifTrue: [self writeFault: address].
	address > writableLimit ifTrue: [self writeFault: address].
	^memory signedByteAt: address + 1 put: value