debug printing
printHexnp: anInteger

	traceOn ifTrue:
		[transcript nextPutAll: ((anInteger ifNil: [0]) storeStringBase: 16)]