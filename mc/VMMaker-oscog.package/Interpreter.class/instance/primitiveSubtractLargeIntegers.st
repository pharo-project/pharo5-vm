arithmetic largeint primitives
primitiveSubtractLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| integerRcvr integerArg integerArgNegated result oopResult |
	<export: true>
	<var: 'integerRcvr' type: 'sqLong'>
	<var: 'integerArg' type: 'sqLong'>
	<var: 'integerArgNegated' type: 'sqLong'>
	<var: 'result' type: 'sqLong'>

	integerArg := self signed64BitValueOf: (self stackValue: 0).
	integerRcvr := self signed64BitValueOf: (self stackValue: 1).
	successFlag ifFalse:
		[^nil].

	"In the test for the argument being most -ve we would
	 have to check for zero if we don't do so here.
	 So do so here and short-circuit the whole subtraction."
	integerArg = 0
		ifTrue: [result := integerRcvr]
		ifFalse:
			["Reverse the argument so that we can recycle the overflow code from addition.
			 But the most -ve 64-bit value can overflow, so check; 0 - most -ve = most -ve"
			integerArgNegated := 0 - integerArg.
			integerArgNegated = integerArg ifTrue:
				[^self primitiveFail].

			"Compute the preliminary result (which may overflow)"
			result := integerRcvr + integerArgNegated.

			"Now check overflow conditions. First is whether rcvr and arg are of the same sign.
			 If they are we need to check for overflow more carefully."
			(integerRcvr bitXor: integerArgNegated) < 0 ifFalse:
				"Second is whether rcvr and result are of the same sign. If not, we have an overflow."
				[(integerRcvr bitXor: result) < 0 ifTrue:
					[^self primitiveFail]]].

	oopResult := self signed64BitIntegerFor: result.
	successFlag ifTrue:
		[self pop: 2 thenPush: oopResult]