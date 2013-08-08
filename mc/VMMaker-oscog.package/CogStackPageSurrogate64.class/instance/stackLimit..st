accessing
stackLimit: aValue
	self assert: (address >= zoneBase and: [address + 7 < zoneLimit]).
	^memory unsignedLongLongAt: address + 1 put: aValue