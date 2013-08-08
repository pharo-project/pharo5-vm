memory access
long32At: byteAddress
	"Return the 32-bit word at byteAddress which must be 0 mod 4."
	^objectMemory long32At: byteAddress