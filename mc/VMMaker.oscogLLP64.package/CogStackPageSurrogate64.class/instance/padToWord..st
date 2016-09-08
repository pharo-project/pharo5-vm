accessing
padToWord: aValue
	self assert: (address + 60 >= zoneBase and: [address + 63 < zoneLimit]).
	^memory longAt: address + 61 put: aValue