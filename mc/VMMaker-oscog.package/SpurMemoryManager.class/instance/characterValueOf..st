immediates
characterValueOf: oop
	"Immediate characters are unsigned"
	^(self cCoerceSimple: oop to: #'unsigned long') >> self numTagBits