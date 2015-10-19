accessing
trace: aValue
	self assert: (address + 56 >= zoneBase and: [address + 63 < zoneLimit]).
	^memory long64At: address + 57 put: aValue