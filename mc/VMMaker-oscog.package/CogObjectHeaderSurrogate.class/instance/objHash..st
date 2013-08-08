accessing
objHash: aValue
	self assert: (aValue between: 0 and: 16rFFFFFF).
	memory
		unsignedLongAt: address + 5
		put: ((memory unsignedLongAt: address + 5) bitAnd: 16rFF000000) + aValue.
	^aValue