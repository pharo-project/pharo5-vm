accessing
isGrey: aValue
	memory
		unsignedByteAt: address + 4
		put: (((memory unsignedByteAt: address + 4) bitAnd: 16rBF) + ((aValue ifTrue: [1] ifFalse: [0]) bitShift: 6)).
	^aValue