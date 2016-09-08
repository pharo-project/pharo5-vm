common selector sends
bytecodePrimEqualSistaV1
	| rcvr arg aBool |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(objectMemory areIntegers: rcvr and: arg) ifTrue: [^self booleanCheatSistaV1: rcvr = arg].

	self initPrimCall.
	aBool := self primitiveFloatEqual: rcvr toArg: arg.
	self successful ifTrue: [^self booleanCheatSistaV1: aBool].

	messageSelector := self specialSelector: 6.
	argumentCount := 1.
	self normalSend