debug printing
printHexPtr: p
	"Print n in hex, passed to 10 characters in the form '    0x1234'"
	<inline: true>
	<var: #p type: #'void *'>
	self printHex: (self oopForPointer: p)