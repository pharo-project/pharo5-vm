*VMMaker-interpreter simulator
signedIntToLong64
	"Produces a 64-bit value in twos-comp form.  Sorry no error checking"

	self >= 0
		ifTrue: [^ self]
		ifFalse: [^ self + 16r8000000000000000 + 16r8000000000000000]
