accessing
isImmutable: aValue
	memory
		unsignedByteAt: address + 3
		put: (((memory unsignedByteAt: address + 3) bitAnd: 16r7F) + ((aValue ifTrue: [1] ifFalse: [0]) bitShift: 7)).
	^aValue