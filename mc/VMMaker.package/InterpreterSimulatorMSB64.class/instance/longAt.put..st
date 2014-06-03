memory access
longAt: byteAddress put: a64BitValue
	"Note: Adjusted for Smalltalk's 1-based array indexing."

	super longAt: byteAddress put: (a64BitValue bitShift: -32).
	super longAt: byteAddress + 4 put: (a64BitValue bitAnd: 16rFFFFFFFF).
	^ a64BitValue