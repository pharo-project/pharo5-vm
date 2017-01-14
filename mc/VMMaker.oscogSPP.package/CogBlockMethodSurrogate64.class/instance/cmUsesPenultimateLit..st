accessing
cmUsesPenultimateLit: aValue
	memory
		unsignedByteAt: address + baseHeaderSize + 3
		put: (((memory unsignedByteAt: address + baseHeaderSize + 3) bitAnd: 16rFE) + (aValue ifTrue: [1] ifFalse: [0])).
	^aValue