accessing
lastAddress: aValue
	self assert: (address + 24 >= zoneBase and: [address + 27 < zoneLimit]).
	^memory unsignedLongAt: address + 25 put: aValue