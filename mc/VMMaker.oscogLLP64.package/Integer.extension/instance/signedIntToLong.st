*VMMaker-interpreter simulator
signedIntToLong
	"Produces a 32-bit value in twos-comp form. Truncates if out-of-range as per a C cast"

	^self bitAnd: 16rFFFFFFFF