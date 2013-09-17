accessing
nextMethod: aValue
	^memory
		unsignedLongAt: address + 25
		put: ((aValue ifNotNil: [aValue asUnsignedInteger] ifNil: [0]))