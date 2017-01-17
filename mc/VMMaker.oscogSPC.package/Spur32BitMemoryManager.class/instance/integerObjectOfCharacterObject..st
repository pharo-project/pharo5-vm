immediates
integerObjectOfCharacterObject: oop
	"Immediate characters are unsigned"
	^(self cCoerceSimple: oop to: #usqInt) >> 1