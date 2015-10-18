*VMMaker-interpreter simulator
signedIntToShort
	"Produces a 16-bit value in twos-comp form. Truncates if out-of-range as per a C cast"

	^self bitAnd: 16rFFFF