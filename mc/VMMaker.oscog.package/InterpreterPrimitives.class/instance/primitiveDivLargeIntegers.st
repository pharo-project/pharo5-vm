arithmetic largeint primitives
primitiveDivLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| result oopResult a aIsNegative b bIsNegative oopArg oopRcvr rem |
	<export: true>
	<var: 'a' type: 'usqLong'>
	<var: 'b' type: 'usqLong'>
	<var: 'result' type: 'usqLong'>
	<var: 'rem' type: 'usqLong'>

	oopArg := self stackValue: 0.
	oopRcvr := self stackValue: 1.
	aIsNegative := self isNegativeIntegerValueOf: oopRcvr.
	bIsNegative := self isNegativeIntegerValueOf: oopArg.
	a := self magnitude64BitValueOf: oopRcvr.
	b := self magnitude64BitValueOf: oopArg.
	b = 0 ifTrue:[self primitiveFail].
	self successful ifFalse:[^nil].

	result := a // b.
	
	a = 0
		ifFalse: [bIsNegative = aIsNegative
			ifFalse:
				["Round toward negative infinity"
				rem := a \\ b.
				rem = 0 ifFalse:
					["This can not overflow, because b > 1, otherwise rem = 0"
					result := result + 1]]].

	oopResult := self magnitude64BitIntegerFor: result neg: bIsNegative ~= aIsNegative.
	self successful ifTrue: [self pop: 2 thenPush: oopResult].