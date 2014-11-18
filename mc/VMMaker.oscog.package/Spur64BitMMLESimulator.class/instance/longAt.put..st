memory access
longAt: byteAddress put: a32BitValue
	"Store the 64-bit value at byteAddress which must be 0 mod 4."

	^self long64At: byteAddress put: a32BitValue