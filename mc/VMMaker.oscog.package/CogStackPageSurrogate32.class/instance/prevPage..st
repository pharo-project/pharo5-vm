accessing
prevPage: aValue
	self assert: (address + 36 >= zoneBase and: [address + 39 < zoneLimit]).
	memory unsignedLongAt: address + 37 put: aValue asInteger.
	^aValue