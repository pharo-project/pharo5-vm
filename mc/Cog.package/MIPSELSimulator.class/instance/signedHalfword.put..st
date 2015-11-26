memory
signedHalfword: address put: value
	(address bitAnd: 1) = 0 ifFalse: [self error: 'Unaligned read'].
	address < writableBase ifTrue: [self writeFault: address].
	address > writableLimit ifTrue: [self writeFault: address].
	^memory signedShortAt: address + 1 put: value