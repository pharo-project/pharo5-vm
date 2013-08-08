accessing
isRemembered: aValue
	memory
		unsignedByteAt: address + 4
		put: (((memory unsignedByteAt: address + 4) bitAnd: 16r7F) + ((aValue ifTrue: [1] ifFalse: [0]) bitShift: 7)).
	^aValue