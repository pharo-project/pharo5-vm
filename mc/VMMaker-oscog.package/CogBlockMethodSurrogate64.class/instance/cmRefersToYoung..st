accessing
cmRefersToYoung: aValue
	memory
		unsignedByteAt: address + 10
		put: (((memory unsignedByteAt: address + 10) bitAnd: 16rF7) + ((aValue ifTrue: [1] ifFalse: [0]) bitShift: 3)).
	^aValue