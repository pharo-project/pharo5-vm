registers
printRegistersOn: stream
	0 to: 31 do:
		[:reg |
		stream space.
		stream nextPutAll: (MIPSConstants nameForRegister: reg).
		stream space.
		(self unsignedRegister: reg) printOn: stream base: 16 nDigits: 8.
		stream space.
		(self signedRegister: reg) printOn: stream.
		stream cr].

	stream nextPutAll: ' hi '.
	hi printOn: stream base: 16 nDigits: 8.
	stream space.
	hi printOn: stream.
	stream cr.
	
	stream nextPutAll: ' lo '.
	lo printOn: stream base: 16 nDigits: 8.
	stream space.
	lo printOn: stream.
	stream cr.
	
	stream nextPutAll: ' pc '.
	pc printOn: stream base: 16 nDigits: 8.
	stream space.
	pc printOn: stream.
	stream cr.