primitives
getByteNonFunctional
	"Return a byte from a non-functional method"
	<returnTypeC: 'unsigned char'>
	self msg: 'yo'.
	^12345