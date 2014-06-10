debug printing
printHexnp: n
	"Print n in hex,  in the form '0x1234', unpadded"
	self print: '0x%x' f: n