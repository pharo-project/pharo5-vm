accessing
isMarked: aValue
	memory
		unsignedByteAt: address + 4
		put: (((memory unsignedByteAt: address + 4) bitAnd: 16rDF) + ((aValue ifTrue: [1] ifFalse: [0]) bitShift: 5)).
	^aValue