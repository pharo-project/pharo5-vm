debug printing
printHexnp: anInteger

	traceOn ifTrue:
		[transcript nextPutAll: ((anInteger ifNil: [0]) asInteger storeStringBase: 16)]