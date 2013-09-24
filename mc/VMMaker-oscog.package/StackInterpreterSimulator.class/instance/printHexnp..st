debug printing
printHexnp: anInteger

	traceOn ifTrue:
		[transcript nextPutAll: (anInteger storeStringBase: 16)]