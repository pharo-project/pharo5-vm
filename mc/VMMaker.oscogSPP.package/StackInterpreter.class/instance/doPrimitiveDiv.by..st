arithmetic primitive support
doPrimitiveDiv: rcvr by: arg
	"Rounds negative results towards negative infinity, rather than zero."
	| result posArg posRcvr integerRcvr integerArg |
	(objectMemory areIntegers: rcvr and: arg)
		ifTrue: [integerRcvr := objectMemory integerValueOf: rcvr.
				integerArg := objectMemory integerValueOf: arg.
				self success: integerArg ~= 0]
		ifFalse: [self primitiveFail].
	self successful ifFalse: [^ 1 "fail"].

	integerRcvr > 0
		ifTrue: [integerArg > 0
					ifTrue: [result := integerRcvr // integerArg]
					ifFalse: ["round negative result toward negative infinity"
							posArg := 0 - integerArg.
							result := 0 - ((integerRcvr + (posArg - 1)) // posArg)]]
		ifFalse: [posRcvr := 0 - integerRcvr.
				integerArg > 0
					ifTrue: ["round negative result toward negative infinity"
							result := 0 - ((posRcvr + (integerArg - 1)) // integerArg)]
					ifFalse: [posArg := 0 - integerArg.
							result := posRcvr // posArg]].
	self success: (objectMemory isIntegerValue: result).
	^ result