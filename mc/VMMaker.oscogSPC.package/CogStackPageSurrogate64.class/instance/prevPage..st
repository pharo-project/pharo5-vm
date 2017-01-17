accessing
prevPage: aValue
	self assert: (address + 72 >= zoneBase and: [address + 79 < zoneLimit]).
	memory unsignedLong64At: address + 73 put: aValue asInteger.
	^aValue