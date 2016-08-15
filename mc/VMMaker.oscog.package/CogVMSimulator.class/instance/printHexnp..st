debug printing
printHexnp: anInteger

	traceOn ifTrue:
		[transcript nextPutAll: (anInteger asInteger storeStringBase: 16)]