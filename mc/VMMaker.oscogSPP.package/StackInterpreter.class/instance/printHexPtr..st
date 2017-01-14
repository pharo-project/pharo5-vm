debug printing
printHexPtr: p
	"Print p in hex, padded to 10 characters in the form '    0x1234'"
	<inline: true>
	<var: #p type: #'void *'>
	self printHex: (self oopForPointer: p)