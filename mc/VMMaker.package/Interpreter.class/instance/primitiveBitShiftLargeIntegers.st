arithmetic largeint primitives
primitiveBitShiftLargeIntegers
	"Primitive logical operations for large integers in 64 bit range"
	| shifted integerArg integerRcvr oopResult |
	<export: true>
	<var: 'integerRcvr' type: 'sqLong'>
	<var: 'integerArg' type: 'sqLong'>
	<var: 'shifted' type: 'sqLong'>

	integerArg := self stackIntegerValue: 0.
	integerRcvr := self signed64BitValueOf: (self stackValue: 1).

	successFlag ifTrue: [
		integerArg >= 0 ifTrue: [
			"Left shift -- must fail if we lose bits beyond 64"
			self success: integerArg < 64.
			shifted := integerRcvr << integerArg.
			self success: (self cCode: 'shifted >> integerArg') = integerRcvr.
		] ifFalse: [
			"Right shift -- OK to lose bits"
			self success: integerArg > -64.
			shifted := self cCode: 'integerRcvr >> (0 - integerArg)'. "right shift coerces to usqInt"
		].
	].
	successFlag ifFalse:[^nil].
	oopResult := self signed64BitIntegerFor: shifted.
	successFlag ifTrue:[self pop: 2 thenPush: oopResult].
