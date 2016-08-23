arithmetic primitive support
doPrimitiveMod: rcvr by: arg
	| integerResult integerRcvr integerArg |
	(objectMemory areIntegers: rcvr and: arg)
		ifTrue: [integerRcvr := objectMemory integerValueOf: rcvr.
				integerArg := objectMemory integerValueOf: arg.
				self success: integerArg ~= 0]
		ifFalse: [self primitiveFail].
	self successful ifFalse: [^ 1 "fail"].

	integerResult := integerRcvr \\ integerArg.

	"ensure that the result has the same sign as the integerArg"
	integerArg < 0
		ifTrue: [integerResult > 0
			ifTrue: [integerResult := integerResult + integerArg]]
		ifFalse: [integerResult < 0
			ifTrue: [integerResult := integerResult + integerArg]].
	self success: (objectMemory isIntegerValue: integerResult).
	^ integerResult