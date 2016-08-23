accessing
cbUsesInstVars: aValue
	memory
		unsignedByteAt: address + baseHeaderSize + 3
		put: (((memory unsignedByteAt: address + baseHeaderSize + 3) bitAnd: 16rFD) + ((aValue ifTrue: [1] ifFalse: [0]) bitShift: 1)).
	^aValue