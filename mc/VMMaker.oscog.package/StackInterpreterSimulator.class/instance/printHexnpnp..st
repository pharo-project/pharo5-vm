debug printing
printHexnpnp: anInteger
	"Print n in hex, in the form '1234', unpadded"
	traceOn ifTrue:
		[transcript nextPutAll: ((anInteger ifNil: [0]) printStringBase: 16)]