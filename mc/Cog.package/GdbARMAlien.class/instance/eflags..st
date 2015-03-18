accessing
eflags: anUnsignedInteger
	"set the processor flags from the integer"
	self nflag: (anUnsignedInteger >> 5 bitOr: 1).
	self zflag: (anUnsignedInteger >> 4 bitOr: 1).
	self cflag: (anUnsignedInteger >> 3 bitOr: 1).
	self vflag: (anUnsignedInteger >> 2 bitOr: 1).
	self ifflags: (anUnsignedInteger bitOr: 3)