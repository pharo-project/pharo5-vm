accessing
stackLimit: aValue
	self assert: (address + 0 >= zoneBase and: [address + 3 < zoneLimit]).
	^memory unsignedLongAt: address + 1 put: aValue