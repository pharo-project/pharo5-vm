accessing
baseFP: aValue
	self assert: (address + 24 >= zoneBase and: [address + 31 < zoneLimit]).
	^memory long64At: address + 25 put: aValue