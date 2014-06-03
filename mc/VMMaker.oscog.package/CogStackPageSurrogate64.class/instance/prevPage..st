accessing
prevPage: aValue
	self assert: (address + 72 >= zoneBase and: [address + 79 < zoneLimit]).
	^memory
		unsignedLongLongAt: address + 73
		put: aValue asInteger