accessing
baseAddress: aValue
	self assert: (address + 16 >= zoneBase and: [address + 19 < zoneLimit]).
	^memory unsignedLongAt: address + 17 put: aValue