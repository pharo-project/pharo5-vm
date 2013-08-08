common selector sends
bytecodePrimEquivalent

	| rcvr arg |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	self booleanCheat: rcvr = arg.