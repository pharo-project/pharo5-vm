accessing
trace: aValue
	self assert: (address + 56 >= zoneBase and: [address + 59 < zoneLimit]).
	^memory longAt: address + 57 put: aValue