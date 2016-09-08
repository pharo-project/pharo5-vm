*VMMaker-interpreter simulator
signedIntToLong64
	"Produces a 64-bit value in twos-comp form. Truncates if out-of-range as per a C cast"

	^self bitAnd: 16rFFFFFFFFFFFFFFFF