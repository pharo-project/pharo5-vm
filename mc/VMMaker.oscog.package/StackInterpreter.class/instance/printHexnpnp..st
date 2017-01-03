debug printing
printHexnpnp: n
	"Print n in hex, in the form '1234', unpadded"
	self print: '%lx' f: (self cCoerceSimple: n to: #'unsigned long')