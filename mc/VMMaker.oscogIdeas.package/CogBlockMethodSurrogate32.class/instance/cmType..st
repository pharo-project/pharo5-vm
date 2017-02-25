accessing
cmType: aValue
	self assert: (aValue between: 0 and: 16r7).
	memory
		unsignedByteAt: address + baseHeaderSize + 2
		put: ((memory unsignedByteAt: address + baseHeaderSize + 2) bitAnd: 16rF8) + aValue.
	^aValue