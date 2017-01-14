accessing
realStackLimit: aValue
	self assert: (address + 40 >= zoneBase and: [address + 47 < zoneLimit]).
	^memory unsignedLong64At: address + 41 put: aValue