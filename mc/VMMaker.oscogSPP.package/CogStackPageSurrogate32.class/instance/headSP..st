accessing
headSP: aValue
	self assert: (address + 4 >= zoneBase and: [address + 7 < zoneLimit]).
	^memory unsignedLongAt: address + 5 put: aValue