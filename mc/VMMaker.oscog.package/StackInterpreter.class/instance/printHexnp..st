debug printing
printHexnp: n
	<api>
	"Print n in hex,  in the form '0x1234', unpadded"
	self print: '0x%lx' f: (self cCoerceSimple: n to: #'unsigned long')