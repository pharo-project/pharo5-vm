accessing
stackLimit: aValue
	self assert: (address >= zoneBase and: [address + 3 < zoneLimit]).
	^memory unsignedLongAt: address + 1 put: aValue signedIntToLong