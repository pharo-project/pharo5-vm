accessing
nextPage: aValue
	self assert: (address + 64 >= zoneBase and: [address + 71 < zoneLimit]).
	^memory
		unsignedLongLongAt: address + 65
		put: aValue asInteger