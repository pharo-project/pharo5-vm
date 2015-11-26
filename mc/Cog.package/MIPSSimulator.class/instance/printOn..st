as yet unclassified
printOn: stream
	stream nextPutAll: self class name; nextPut: $:; cr.
	0 to: 31 do:
		[:reg |
		stream space.
		stream nextPutAll: (MIPSConstants nameForRegister: reg).
		stream space.
		(self unsignedRegister: reg) printOn: stream base: 16 nDigits: 8.
		stream space.
		(self signedRegister: reg) printOn: stream.
		stream cr].

	stream nextPutAll: ' pc '.
	pc printOn: stream base: 16 nDigits: 8.
	stream space.
	pc printOn: stream.
	stream cr.
	
	stream nextPutAll: self currentInstruction.