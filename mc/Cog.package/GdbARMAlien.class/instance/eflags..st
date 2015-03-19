accessing
eflags: anUnsignedInteger
	"set the processor flags from the integer"
	self nflag: (anUnsignedInteger >> 5 bitAnd: 1).
	self zflag: (anUnsignedInteger >> 4 bitAnd: 1).
	self cflag: (anUnsignedInteger >> 3 bitAnd: 1).
	self vflag: (anUnsignedInteger >> 2 bitAnd: 1).
	self ifflags: (anUnsignedInteger bitAnd: 3)