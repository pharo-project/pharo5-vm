memory access
longAt: byteAddress
	"Note: Adjusted for Smalltalk's 1-based array indexing."

	^ ((super longAt: byteAddress) bitShift: 32) bitOr: (super longAt: byteAddress + 4)