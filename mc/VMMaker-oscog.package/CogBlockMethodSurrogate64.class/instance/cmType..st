accessing
cmType: aValue
	self assert: (aValue between: 0 and: 16r7).
	memory
		unsignedByteAt: address + 10
		put: ((memory unsignedByteAt: address + 10) bitAnd: 16rF8) + aValue.
	^aValue