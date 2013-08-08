accessing
stackCheckOffset: aValue
	self assert: (aValue between: 0 and: 16rFFF).
	memory
		unsignedShortAt: address + 7
		put: ((memory unsignedShortAt: address + 7) bitAnd: 16rF) + (aValue bitShift: 4).
	^aValue