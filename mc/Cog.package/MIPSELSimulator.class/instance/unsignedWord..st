memory
unsignedWord: address
	address < readableBase ifTrue: [self readFault: address].
	address > readableLimit ifTrue: [self readFault: address].
	(address bitAnd: 3) = 0 ifFalse: [self error: 'Unaligned read'].
	^memory unsignedLongAt: address + 1 bigEndian: false