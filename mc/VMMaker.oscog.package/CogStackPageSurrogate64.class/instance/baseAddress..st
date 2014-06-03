accessing
baseAddress: aValue
	self assert: (address + 32 >= zoneBase and: [address + 39 < zoneLimit]).
	^memory unsignedLongLongAt: address + 33 put: aValue