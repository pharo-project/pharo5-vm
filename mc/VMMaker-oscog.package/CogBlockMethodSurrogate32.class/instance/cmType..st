accessing
cmType: aValue
	self assert: (aValue between: 0 and: 16r7).
	memory
		unsignedByteAt: address + 6
		put: ((memory unsignedByteAt: address + 6) bitAnd: 16rF8) + aValue.
	^aValue