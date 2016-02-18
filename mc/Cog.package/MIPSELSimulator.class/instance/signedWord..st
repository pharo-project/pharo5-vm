memory
signedWord: address
	(address bitAnd: 3) = 0 ifFalse: [self error: 'Unaligned read'].
	address < readableBase ifTrue: [self readFault: address].
	address > readableLimit ifTrue: [self readFault: address].		
	^memory longAt: address + 1