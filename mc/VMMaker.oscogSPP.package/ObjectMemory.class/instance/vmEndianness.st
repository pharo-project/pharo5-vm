memory access
vmEndianness
	"return 0 for little endian, 1 for big endian"
	"?!*#$%! _Terrible_ name. Call it what it is.
	 VMBIGENDIAN or VMLITTLEENDIAN.  Dont leave us guessing!!!!
	 Alas this has to remain for backward compatibility."

	^VMBIGENDIAN ifTrue: [1] ifFalse: [0]