memory
unsignedHalfword: address
	address < readableBase ifTrue: [self readFault: address].
	address > readableLimit ifTrue: [self readFault: address].
	(address bitAnd: 1) = 0 ifFalse: [self error: 'Unaligned read'].
	^memory unsignedShortAt: address + 1