common selector sends
bytecodePrimEqualV4
	| rcvr arg aBool |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(objectMemory areIntegers: rcvr and: arg) ifTrue: [^self booleanCheatV4: rcvr = arg].

	self initPrimCall.
	aBool := self primitiveFloatEqual: rcvr toArg: arg.
	self successful ifTrue: [^self booleanCheatV4: aBool].

	messageSelector := self specialSelector: 6.
	argumentCount := 1.
	self normalSend