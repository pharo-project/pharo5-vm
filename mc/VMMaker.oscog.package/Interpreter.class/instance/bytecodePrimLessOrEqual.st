common selector sends
bytecodePrimLessOrEqual
	| rcvr arg aBool |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(self areIntegers: rcvr and: arg) ifTrue:
		[self cCode: '' inSmalltalk: [^self booleanCheat: (self integerValueOf: rcvr) <= (self integerValueOf: arg)].
		^ self booleanCheat: rcvr <= arg].

	successFlag := true.
	aBool := self primitiveFloatLessOrEqual: rcvr toArg: arg.
	successFlag ifTrue: [^self booleanCheat: aBool].

	messageSelector := self specialSelector: 4.
	argumentCount := 1.
	self normalSend