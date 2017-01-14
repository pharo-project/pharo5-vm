accessing
stackLimit: aValue
	self assert: (address + 0 >= zoneBase and: [address + 7 < zoneLimit]).
	^memory unsignedLong64At: address + 1 put: aValue