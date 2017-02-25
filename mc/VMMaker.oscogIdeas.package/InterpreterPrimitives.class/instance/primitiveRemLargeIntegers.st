arithmetic largeint primitives
primitiveRemLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| result oopResult a aIsNegative b oopArg oopRcvr |
	<export: true>
	<var: 'a' type: 'usqLong'>
	<var: 'b' type: 'usqLong'>
	<var: 'result' type: 'usqLong'>

	oopArg := self stackValue: 0.
	oopRcvr := self stackValue: 1.
	aIsNegative := self isNegativeIntegerValueOf: oopRcvr.
	a := self magnitude64BitValueOf: oopRcvr.
	b := self magnitude64BitValueOf: oopArg.
	b = 0 ifTrue:[self primitiveFail].
	self successful ifFalse:[^nil].

	result := a \\ b.

	oopResult := self magnitude64BitIntegerFor: result neg: aIsNegative.
	self successful ifTrue: [self pop: 2 thenPush: oopResult].