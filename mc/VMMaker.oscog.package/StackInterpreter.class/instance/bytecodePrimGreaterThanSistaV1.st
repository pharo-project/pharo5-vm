common selector sends
bytecodePrimGreaterThanSistaV1
	| rcvr arg aBool |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(objectMemory areIntegers: rcvr and: arg) ifTrue:
		["The C code can avoid detagging since tagged integers are still signed.
		 But this means the simulator must override to do detagging."
		^self cCode: [self booleanCheatSistaV1: rcvr > arg]
			inSmalltalk: [self booleanCheatSistaV1: (objectMemory integerValueOf: rcvr) > (objectMemory integerValueOf: arg)]].

	self initPrimCall.
	aBool := self primitiveFloatGreater: rcvr thanArg: arg.
	self successful ifTrue: [^self booleanCheatSistaV1: aBool].

	messageSelector := self specialSelector: 3.
	argumentCount := 1.
	self normalSend