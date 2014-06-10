arithmetic largeint primitives
primitiveMultiplyLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| integerRcvr integerArg result oopResult |
	<export: true>
	<var: 'integerRcvr' type: 'sqLong'>
	<var: 'integerArg' type: 'sqLong'>
	<var: 'result' type: 'sqLong'>

	integerArg := self signed64BitValueOf: (self stackValue: 0).
	integerRcvr := self signed64BitValueOf: (self stackValue: 1).
	successFlag ifFalse:[^nil].

	result := integerRcvr * integerArg.
	"check for C overflow by seeing if computation is reversible"
	((integerArg = 0) or: [(result // integerArg) = integerRcvr])
		ifTrue:[oopResult := self signed64BitIntegerFor: result]
		ifFalse: [self primitiveFail].

	successFlag ifTrue:[self pop: 2 thenPush: oopResult].
