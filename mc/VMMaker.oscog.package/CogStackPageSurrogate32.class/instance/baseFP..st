accessing
baseFP: aValue
	self assert: (address + 12 >= zoneBase and: [address + 15 < zoneLimit]).
	^memory unsignedLongAt: address + 13 put: aValue