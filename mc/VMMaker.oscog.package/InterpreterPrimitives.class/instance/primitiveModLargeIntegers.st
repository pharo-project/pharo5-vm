arithmetic largeint primitives
primitiveModLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| result oopResult a aIsNegative b bIsNegative oopArg oopRcvr |
	<export: true>
	<var: 'a' type: 'usqLong'>
	<var: 'b' type: 'usqLong'>
	<var: 'result' type: 'usqLong'>

	oopArg := self stackValue: 0.
	oopRcvr := self stackValue: 1.
	aIsNegative := self isNegativeIntegerValueOf: oopRcvr.
	bIsNegative := self isNegativeIntegerValueOf: oopArg.
	a := self magnitude64BitValueOf: oopRcvr.
	b := self magnitude64BitValueOf: oopArg.
	b = 0 ifTrue:[self primitiveFail].
	self successful ifFalse:[^nil].

	result := a \\ b.

	"Handle remainder of same sign as argument"
	result = 0
		ifFalse: [bIsNegative = aIsNegative
			ifFalse: [result := b - result]].

	oopResult := self magnitude64BitIntegerFor: result neg: bIsNegative.
	self successful ifTrue: [self pop: 2 thenPush: oopResult].
