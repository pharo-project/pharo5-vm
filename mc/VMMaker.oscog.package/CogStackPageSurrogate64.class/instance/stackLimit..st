accessing
stackLimit: aValue
	self assert: (address >= zoneBase and: [address + 7 < zoneLimit]).
	^memory long64At: address + 1 put: aValue