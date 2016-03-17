arithmetic largeint primitives
primitiveBitXorLargeIntegers
	"Primitive logical operations for large integers in 64 bit range"
	| integerRcvr integerArg oopResult |
	<export: true>
	<var: 'integerRcvr' type: 'usqLong'>
	<var: 'integerArg' type: 'usqLong'>

	integerArg := self positive64BitValueOf: (self stackValue: 0).
	integerRcvr := self positive64BitValueOf: (self stackValue: 1).
	self successful ifFalse:[^nil].

	oopResult := self positive64BitIntegerFor: (integerRcvr bitXor: integerArg).
	self successful ifTrue:[self pop: 2 thenPush: oopResult]