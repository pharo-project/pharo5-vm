accessing
lastAddress: aValue
	self assert: (address + 48 >= zoneBase and: [address + 55 < zoneLimit]).
	^memory unsignedLong64At: address + 49 put: aValue