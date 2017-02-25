accessing
stackCheckOffset: aValue
	self assert: (aValue between: 0 and: 16rFFF).
	memory
		unsignedShortAt: address + baseHeaderSize + 3
		put: ((memory unsignedShortAt: address + baseHeaderSize + 3) bitAnd: 16rF) + (aValue bitShift: 4).
	^aValue