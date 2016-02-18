*VMMaker-interpreter simulator
signedIntToChar
	"Produces an 8-bit value in twos-comp form. Truncates if out-of-range as per a C cast"

	^self bitAnd: 16rFF