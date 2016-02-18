memory
signedHalfword: address
	(address bitAnd: 1) = 0 ifFalse: [self error: 'Unaligned read'].
	address < readableBase ifTrue: [self readFault: address].
	address > readableLimit ifTrue: [self readFault: address].
	^memory signedShortAt: address + 1