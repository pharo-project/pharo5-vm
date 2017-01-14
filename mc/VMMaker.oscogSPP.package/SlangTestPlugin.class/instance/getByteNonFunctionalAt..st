primitives
getByteNonFunctionalAt: addr
	"Return a byte from a non-functional method"
	<returnTypeC: 'unsigned char'>
	self msg: 'yo'.
	^interpreterProxy longAt: addr