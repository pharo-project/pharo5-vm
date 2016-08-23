accessing
nextPage: aValue
	self assert: (address + 32 >= zoneBase and: [address + 35 < zoneLimit]).
	memory unsignedLongAt: address + 33 put: aValue asInteger.
	^aValue