common selector sends
bytecodePrimIdentical
	| rcvr arg |
	rcvr := self internalStackValue: 1.
	(objectMemory isOopForwarded: rcvr) ifTrue:
		[rcvr := self handleSpecialSelectorSendFaultFor: rcvr].
	arg := self internalStackValue: 0.
	(objectMemory isOopForwarded: arg) ifTrue:
		[arg := self handleSpecialSelectorSendFaultFor: arg].
	self booleanCheat: rcvr = arg