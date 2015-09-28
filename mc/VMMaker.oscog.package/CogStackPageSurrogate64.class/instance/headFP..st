accessing
headFP: aValue
	self assert: (address + 16 >= zoneBase and: [address + 23 < zoneLimit]).
	^memory long64At: address + 17 put: aValue