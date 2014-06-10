accessing
cmRefersToYoung: aValue
	memory
		unsignedByteAt: address + baseHeaderSize + 2
		put: (((memory unsignedByteAt: address + baseHeaderSize + 2) bitAnd: 16rF7) + ((aValue ifTrue: [1] ifFalse: [0]) bitShift: 3)).
	^aValue