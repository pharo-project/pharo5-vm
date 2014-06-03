accessing
cmIsUnlinked: aValue
	memory
		unsignedByteAt: address + 10
		put: (((memory unsignedByteAt: address + 10) bitAnd: 16rEF) + ((aValue ifTrue: [1] ifFalse: [0]) bitShift: 4)).
	^aValue