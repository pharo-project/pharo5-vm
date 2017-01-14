common selector sends
bytecodePrimNotEqualSistaV1
	| rcvr arg aBool |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(objectMemory areIntegers: rcvr and: arg) ifTrue: [^self booleanCheatSistaV1: rcvr ~= arg].

	self initPrimCall.
	aBool := self primitiveFloatEqual: rcvr toArg: arg.
	self successful ifTrue: [^self booleanCheatSistaV1: aBool not].

	messageSelector := self specialSelector: 7.
	argumentCount := 1.
	self normalSend