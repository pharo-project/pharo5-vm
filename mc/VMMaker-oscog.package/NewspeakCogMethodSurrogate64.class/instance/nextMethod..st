accessing
nextMethod: aValue
	^memory
		unsignedLongLongAt: address + 41
		put: ((aValue ifNotNil: [aValue asUnsignedInteger] ifNil: [0]))