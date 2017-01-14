accessing
realStackLimit: aValue
	self assert: (address + 20 >= zoneBase and: [address + 23 < zoneLimit]).
	^memory unsignedLongAt: address + 21 put: aValue