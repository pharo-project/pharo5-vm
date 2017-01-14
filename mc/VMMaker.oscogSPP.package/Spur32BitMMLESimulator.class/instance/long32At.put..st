memory access
long32At: byteAddress put: a32BitValue
	"Store the 32-bit value at byteAddress which must be 0 mod 4."

	^self longAt: byteAddress put: a32BitValue