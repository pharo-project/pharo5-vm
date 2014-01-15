accessing
format: aValue
	self assert: (aValue between: 0 and: 16r1F).
	memory
		unsignedByteAt: address + 4
		put: ((memory unsignedByteAt: address + 4) bitAnd: 16rE0) + aValue.
	^aValue