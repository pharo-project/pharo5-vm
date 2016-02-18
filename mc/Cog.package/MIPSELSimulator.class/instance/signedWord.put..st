memory
signedWord: address put: value
	(address bitAnd: 3) = 0 ifFalse: [self error: 'Unaligned read'].
	address < writableBase ifTrue: [self writeFault: address].
	address > writableLimit ifTrue: [self writeFault: address].
	^memory longAt: address + 1 put: value