*VMMaker-interpreter simulator
signedIntToLong
	"Produces a 32-bit value in twos-comp form.  Sorry no error checking"

	self >= 0
		ifTrue: [^ self]
		ifFalse: [^ self + 16r80000000 + 16r80000000]
