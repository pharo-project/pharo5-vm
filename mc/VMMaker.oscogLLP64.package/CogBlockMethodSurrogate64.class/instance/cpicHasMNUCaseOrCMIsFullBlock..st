accessing
cpicHasMNUCaseOrCMIsFullBlock: aValue
	memory
		unsignedByteAt: address + baseHeaderSize + 2
		put: (((memory unsignedByteAt: address + baseHeaderSize + 2) bitAnd: 16rEF) + ((aValue ifTrue: [1] ifFalse: [0]) bitShift: 4)).
	^aValue