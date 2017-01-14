common selector sends
bytecodePrimNotIdenticalV4
	| rcvr arg |
	rcvr := self internalStackValue: 1.
	arg := self internalStackValue: 0.
	(objectMemory isOopForwarded: rcvr) ifTrue:
		[rcvr := self handleSpecialSelectorSendFaultFor: rcvr].
	(objectMemory isOopForwarded: arg) ifTrue:
		[arg := self handleSpecialSelectorSendFaultFor: arg].
	self booleanCheatV4: rcvr ~= arg