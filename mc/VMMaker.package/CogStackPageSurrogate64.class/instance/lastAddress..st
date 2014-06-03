accessing
lastAddress: aValue
	self assert: (address + 48 >= zoneBase and: [address + 35 < zoneLimit]).
	^memory unsignedLongLongAt: address + 49 put: aValue