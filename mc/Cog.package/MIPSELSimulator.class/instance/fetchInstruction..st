memory
fetchInstruction: address
	address < exectuableBase ifTrue: [self executeFault: address].
	address > exectuableLimit ifTrue: [self executeFault: address].
	(address bitAnd: 3) = 0 ifFalse: [self error: 'Unaligned read'].
	^memory unsignedLongAt: address + 1 bigEndian: false