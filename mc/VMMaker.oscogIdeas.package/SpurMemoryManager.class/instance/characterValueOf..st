immediates
characterValueOf: oop
	"Immediate characters are unsigned"
	<api>
	^oop asUnsignedInteger >> self numTagBits