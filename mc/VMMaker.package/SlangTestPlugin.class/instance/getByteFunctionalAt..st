primitives
getByteFunctionalAt: addr
	"Return a byte from a (semi-)functional method"
	<returnTypeC: 'unsigned char'>
	^interpreterProxy longAt: addr