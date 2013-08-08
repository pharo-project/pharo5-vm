accessing
cmUsesPenultimateLit: aValue
	memory
		unsignedByteAt: address + 7
		put: (((memory unsignedByteAt: address + 7) bitAnd: 16rFE) + (aValue ifTrue: [1] ifFalse: [0])).
	^aValue