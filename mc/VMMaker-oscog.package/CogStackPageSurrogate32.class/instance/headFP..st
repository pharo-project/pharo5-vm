accessing
headFP: aValue
	self assert: (address + 8 >= zoneBase and: [address + 11 < zoneLimit]).
	^memory unsignedLongAt: address + 9 put: aValue