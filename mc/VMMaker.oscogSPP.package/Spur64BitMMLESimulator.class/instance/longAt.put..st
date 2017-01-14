memory access
longAt: byteAddress put: a64BitValue
	"Store the 64-bit value at byteAddress which must be 0 mod 8."
	"byteAddress = 16r43C790 ifTrue: [self halt]."
	^self long64At: byteAddress put: a64BitValue