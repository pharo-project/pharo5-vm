accessing
padToWord: aValue
	self assert: (address + 32 >= zoneBase and: [address + 35 < zoneLimit]).
	^memory longAt: address + 33 put: aValue