debug printing
whereIsMaybeStackThing: anOop
	"If anOop is an address within the stack zone answer a string stating that, otherwise answer nil."
	<returnTypeC: 'char *'>
	(self oop: anOop
		isGreaterThanOrEqualTo: (stackBasePlus1 - 1)
		andLessThan: (self cCode: [pages]
							inSmalltalk: [(self stackPageAt: 0) asUnsignedInteger])) ifTrue:
		[^' is in the stack zone'].
	^nil