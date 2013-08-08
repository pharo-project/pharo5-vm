I/O primitives
primitiveScreenSize
	"Return a point indicating the current size of the Smalltalk window. Currently there is a limit of 65535 in each direction because the point is encoded into a single 32bit value in the image header. This might well become a problem one day"
	| pointWord |
	self pop: 1.
	pointWord := self ioScreenSize.
	self push: (self makePointwithxValue: (pointWord >> 16 bitAnd: 65535) yValue: (pointWord bitAnd: 65535))