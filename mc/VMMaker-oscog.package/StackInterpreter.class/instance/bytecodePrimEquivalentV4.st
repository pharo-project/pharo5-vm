common selector sends
bytecodePrimEquivalentV4

	| rcvr arg |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	self booleanCheatV4: rcvr = arg.