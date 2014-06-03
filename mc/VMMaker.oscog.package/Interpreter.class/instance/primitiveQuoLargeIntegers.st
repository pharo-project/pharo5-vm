arithmetic largeint primitives
primitiveQuoLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| integerRcvr integerArg result oopResult |
	<export: true>
	<var: 'integerRcvr' type: 'sqLong'>
	<var: 'integerArg' type: 'sqLong'>
	<var: 'result' type: 'sqLong'>

	integerArg := self signed64BitValueOf: (self stackValue: 0).
	integerRcvr := self signed64BitValueOf: (self stackValue: 1).
	integerArg = 0 ifTrue:[self primitiveFail].
	successFlag ifFalse:[^nil].

	integerRcvr > 0 ifTrue: [
		integerArg > 0 
			ifTrue: [result := integerRcvr // integerArg]
			ifFalse: [result := 0 - (integerRcvr // (0 - integerArg))].
	] ifFalse: [
		integerArg > 0 
			ifTrue: [result := 0 - ((0 - integerRcvr) // integerArg)]
			ifFalse: [result := (0 - integerRcvr) // (0 - integerArg)].
	].

	oopResult := self signed64BitIntegerFor: result.
	successFlag ifTrue:[self pop: 2 thenPush: oopResult].
