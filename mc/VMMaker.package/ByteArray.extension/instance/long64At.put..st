*VMMaker-accessing
long64At: index put: val
	"I store 64-bit integers in Smalltalk (little-endian) order."
	self unsignedLongAt: index put: (val bitAnd: 16rFFFFFFFF) bigEndian: false.
	self unsignedLongAt: index+4 put: (val bitShift: -32) bigEndian: false.
	^val
