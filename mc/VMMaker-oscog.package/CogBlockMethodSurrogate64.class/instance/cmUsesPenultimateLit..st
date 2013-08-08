accessing
cmUsesPenultimateLit: aValue
	memory
		unsignedByteAt: address + 11
		put: (((memory unsignedByteAt: address + 11) bitAnd: 16rFE) + (aValue ifTrue: [1] ifFalse: [0])).
	^aValue