accessing
nextPage: aValue
	self assert: (address + 64 >= zoneBase and: [address + 71 < zoneLimit]).
	^memory
		long64At: address + 65
		put: aValue asInteger