marshalling
returnStructInRegisters: returnStructSize
	"Answer if a struct result of a given size is returned in memory or not.
	 The ABI spec defines return in registers, but some linux gcc versions implemented an
	 erroneous draft which does not return any struct in memory.  Implement the SysV ABI."
	^returnStructSize <= 8