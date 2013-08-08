accessing
stackCheckOffset: aValue
	self assert: (aValue between: 0 and: 16rFFF).
	memory
		unsignedShortAt: address + 11
		put: ((memory unsignedShortAt: address + 11) bitAnd: 16rF) + (aValue bitShift: 4).
	^aValue