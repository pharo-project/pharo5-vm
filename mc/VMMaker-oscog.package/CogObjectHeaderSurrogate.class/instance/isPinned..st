accessing
isPinned: aValue
	memory
		unsignedByteAt: address + 3
		put: (((memory unsignedByteAt: address + 3) bitAnd: 16rBF) + ((aValue ifTrue: [1] ifFalse: [0]) bitShift: 6)).
	^aValue