accessing
cmUsageCount: aValue
	self assert: (aValue between: 0 and: 16r7).
	memory
		unsignedByteAt: address + baseHeaderSize + 2
		put: ((memory unsignedByteAt: address + baseHeaderSize + 2) bitAnd: 16r1F) + (aValue bitShift: 5).
	^aValue