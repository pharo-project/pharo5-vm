initialize
options: anArrayOfPairs
	self assert: anArrayOfPairs size even.
	1 to: anArrayOfPairs size by: 2 do:
		[:i| | key |
		key := anArrayOfPairs at: i.
		self assert: key isSymbol.
		optionsDictionary at: key put: (anArrayOfPairs at: i + 1)]