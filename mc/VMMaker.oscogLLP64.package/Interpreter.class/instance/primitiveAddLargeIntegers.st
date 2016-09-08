arithmetic largeint primitives
primitiveAddLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| integerRcvr integerArg result oopResult |
	<export: true>
	<var: 'integerRcvr' type: 'sqLong'>
	<var: 'integerArg' type: 'sqLong'>
	<var: 'result' type: 'sqLong'>

	integerArg := self signed64BitValueOf: (self stackValue: 0).
	integerRcvr := self signed64BitValueOf: (self stackValue: 1).
	successFlag ifFalse:[^nil].

	"Compute the preliminary result (which may overflow)"
	result := integerRcvr + integerArg.

	"Now check overflow conditions. First is whether rcvr and arg are of the same sign.
	If they are we need to check for overflow more carefully."
	(integerRcvr bitXor: integerArg) < 0 ifFalse:[
		"Second is whether rcvr and result are of the same sign. If not, we have an overflow."
		(integerRcvr bitXor: result) < 0 ifTrue:[self primitiveFail]].
			
	successFlag ifFalse:[^nil].

	oopResult := self signed64BitIntegerFor: result.
	successFlag ifTrue:[self pop: 2 thenPush: oopResult].
