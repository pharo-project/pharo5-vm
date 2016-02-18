accessing
nextPage: aValue
	self assert: (address + 64 >= zoneBase and: [address + 71 < zoneLimit]).
	memory unsignedLong64At: address + 65 put: aValue asInteger.
	^aValue