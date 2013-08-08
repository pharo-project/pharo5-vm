arithmetic largeint primitives
primitiveDivideLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| integerRcvr integerArg result oopResult |
	<export: true>
	<var: 'integerRcvr' type: 'sqLong'>
	<var: 'integerArg' type: 'sqLong'>
	<var: 'result' type: 'sqLong'>

	integerArg := self signed64BitValueOf: (self stackValue: 0).
	integerRcvr := self signed64BitValueOf: (self stackValue: 1).
	(integerArg ~= 0 and:[integerRcvr \\ integerArg = 0]) ifFalse:[self primitiveFail].
	successFlag ifFalse:[^nil].
	result := integerRcvr // integerArg.
	oopResult := self signed64BitIntegerFor: result.
	successFlag ifTrue:[self pop: 2 thenPush: oopResult].
