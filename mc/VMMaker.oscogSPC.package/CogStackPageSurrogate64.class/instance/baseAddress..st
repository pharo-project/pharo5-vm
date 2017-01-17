accessing
baseAddress: aValue
	self assert: (address + 32 >= zoneBase and: [address + 39 < zoneLimit]).
	^memory unsignedLong64At: address + 33 put: aValue