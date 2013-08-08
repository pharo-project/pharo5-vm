arithmetic largeint primitives
primitiveDivLargeIntegers
	"Primitive arithmetic operations for large integers in 64 bit range"
	| integerRcvr integerArg result posArg posRcvr oopResult |
	<export: true>
	<var: 'integerRcvr' type: 'sqLong'>
	<var: 'integerArg' type: 'sqLong'>
	<var: 'posRcvr' type: 'sqLong'>
	<var: 'posArg' type: 'sqLong'>
	<var: 'result' type: 'sqLong'>

	integerArg := self signed64BitValueOf: (self stackValue: 0).
	integerRcvr := self signed64BitValueOf: (self stackValue: 1).
	integerArg = 0 ifTrue:[self primitiveFail].
	successFlag ifFalse:[^nil].

	integerRcvr > 0
		ifTrue: [integerArg > 0
					ifTrue: [result := integerRcvr // integerArg]
					ifFalse: ["round negative result toward negative infinity"
							posArg := 0 - integerArg.
							posRcvr := integerRcvr + (posArg - 1). "can overflow!"
							posRcvr < 0 ifTrue:[self primitiveFail].
							result := 0 - (posRcvr // posArg)]]
		ifFalse: [posRcvr := 0 - integerRcvr.
				integerArg > 0
					ifTrue: ["round negative result toward negative infinity"
							posRcvr := posRcvr + (integerArg - 1). "can overflow!"
							posRcvr < 0 ifTrue:[self primitiveFail].
							result := 0 - (posRcvr // integerArg)]
					ifFalse: [posArg := 0 - integerArg.
							result := posRcvr // posArg]].
	successFlag ifTrue:[oopResult := self signed64BitIntegerFor: result].
	successFlag ifTrue:[self pop: 2 thenPush: oopResult].
