accessing
trace: aValue
	self assert: (address + 28 >= zoneBase and: [address + 31 < zoneLimit]).
	^memory longAt: address + 29 put: aValue