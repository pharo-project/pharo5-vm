accessing
nextMethod: aValue
	^memory
		unsignedLongAt: address + baseHeaderSize + 21
		put: ((aValue ifNotNil: [aValue asUnsignedInteger] ifNil: [0]))