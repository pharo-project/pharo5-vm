arithmetic largeint primitives
primitiveBitOrLargeIntegers
	"Primitive logical operations for large integers in 64 bit range"
	| integerRcvr integerArg oopResult |
	<export: true>
	<var: 'integerRcvr' type: 'sqLong'>
	<var: 'integerArg' type: 'sqLong'>

	integerArg := self positive64BitValueOf: (self stackValue: 0).
	integerRcvr := self positive64BitValueOf: (self stackValue: 1).
	successFlag ifFalse:[^nil].

	oopResult := self positive64BitIntegerFor: (integerRcvr bitOr: integerArg).
	successFlag ifTrue:[self pop: 2 thenPush: oopResult].
