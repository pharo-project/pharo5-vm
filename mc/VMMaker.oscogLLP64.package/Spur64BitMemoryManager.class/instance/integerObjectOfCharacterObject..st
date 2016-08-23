immediates
integerObjectOfCharacterObject: oop
	"Immediate characters are unsigned"
	^oop - (self characterTag - self smallIntegerTag)