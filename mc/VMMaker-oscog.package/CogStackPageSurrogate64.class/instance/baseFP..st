accessing
baseFP: aValue
	self assert: (address + 24 >= zoneBase and: [address + 31 < zoneLimit]).
	^memory unsignedLongLongAt: address + 25 put: aValue