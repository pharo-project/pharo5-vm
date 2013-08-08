accessing
trace: aValue
	self assert: (address + 28 >= zoneBase and: [address + 31 < zoneLimit]).
	^memory unsignedLongAt: address + 29 put: (16rFFFFFFFF bitAnd: aValue)