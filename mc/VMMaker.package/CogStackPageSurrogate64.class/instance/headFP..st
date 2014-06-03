accessing
headFP: aValue
	self assert: (address + 16 >= zoneBase and: [address + 23 < zoneLimit]).
	^memory unsignedLongLongAt: address + 17 put: aValue