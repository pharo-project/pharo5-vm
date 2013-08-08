*VMMaker-interpreter simulator
signedIntToShort
	"Produces a 16-bit value (0-65k) in twos-comp form.  Sorry no error checking"

	^self bitAnd: 16rFFFF