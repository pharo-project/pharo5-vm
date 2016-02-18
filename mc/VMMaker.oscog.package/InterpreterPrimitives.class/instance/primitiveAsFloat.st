arithmetic float primitives
primitiveAsFloat
	"N.B. This will answer inexact results for integers with > 53 bits of magnitude."
	| rcvr |
	rcvr := self stackTop.
	self assert: (objectMemory isIntegerObject: rcvr).
	self pop: 1 thenPushFloat: (objectMemory integerValueOf: rcvr) asFloat