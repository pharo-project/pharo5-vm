immediates
integerObjectOfCharacterObject: oop
	"Immediate characters are unsigned"
	^(self cCoerceSimple: oop to: #'unsigned long') >> 1