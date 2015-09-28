accessing
lastAddress: aValue
	self assert: (address + 48 >= zoneBase and: [address + 35 < zoneLimit]).
	^memory long64At: address + 49 put: aValue