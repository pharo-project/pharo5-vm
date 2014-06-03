debug printing
whereIsMaybeStackThing: anOop
	<returnTypeC: 'char *'>
	(self oop: anOop
		isGreaterThanOrEqualTo: (stackBasePlus1 - 1)
		andLessThan: (self cCode: [pages]
							inSmalltalk: [(self stackPageAt: 0) asUnsignedInteger])) ifTrue:
		[^' is in the stack zone'].
	^nil