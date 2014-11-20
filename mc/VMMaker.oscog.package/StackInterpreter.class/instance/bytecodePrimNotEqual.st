common selector sends
bytecodePrimNotEqual
	| rcvr arg aBool |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(objectMemory areIntegers: rcvr and: arg) ifTrue: [^self booleanCheat: rcvr ~= arg].

	self initPrimCall.
	aBool := self primitiveFloatEqual: rcvr toArg: arg.
	self successful ifTrue: [^self booleanCheat: aBool not].

	messageSelector := self specialSelector: 7.
	argumentCount := 1.
	self normalSend