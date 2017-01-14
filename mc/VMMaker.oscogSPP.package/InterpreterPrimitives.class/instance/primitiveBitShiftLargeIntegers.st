arithmetic largeint primitives
primitiveBitShiftLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| a shift result oopResult aIsNegative oopRcvr |
	<export: true>
	<var: 'a' type: 'usqLong'>
	<var: 'result' type: 'usqLong'>

	shift := self stackIntegerValue: 0.
	oopRcvr := self stackValue: 1.
	aIsNegative := self isNegativeIntegerValueOf: oopRcvr.
	a := self magnitude64BitValueOf: oopRcvr.
	self successful ifFalse:[^nil].
	(shift >= 0)
		ifTrue:
			["Protect against overflow"
			result := 16rFFFFFFFFFFFFFFFF. "This is to avoid undue (usqInt) cast"
			(shift >= 64 or: [a > (result >> shift)]) ifTrue: [self primitiveFail. ^nil].
			result := a << shift]
		ifFalse:
			[shift := 0 - shift.
			shift >= 64
				ifTrue: [result := 0]
				ifFalse: [result := a >> shift].
			"Fake 2 complement for negative values"
			(aIsNegative and: [result << shift ~= a]) ifTrue: [result := result + 1]].
	oopResult := self magnitude64BitIntegerFor: result neg: aIsNegative.
	self successful ifTrue:[self pop: 2 thenPush: oopResult].