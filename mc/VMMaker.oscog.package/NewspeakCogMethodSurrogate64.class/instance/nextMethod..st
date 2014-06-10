accessing
nextMethod: aValue
	^memory
		unsignedLongLongAt: address + baseHeaderSize + 33
		put: ((aValue ifNotNil: [aValue asUnsignedInteger] ifNil: [0]))