memory access
longAt: byteAddress
	"Answer the 64-bit word at byteAddress which must be 0 mod 4."

	^self long64At: byteAddress