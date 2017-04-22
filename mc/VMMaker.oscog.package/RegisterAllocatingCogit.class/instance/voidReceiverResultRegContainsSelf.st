bytecode generator support
voidReceiverResultRegContainsSelf
	"Used when ReceiverResultReg is allocated for other than simSelf, and
	 there may be references to ReceiverResultReg which need to be spilled."
	self receiverIsInReceiverResultReg ifFalse:
		[self deny: self simSelfOnStackInReceiverResultReg.
		 ^self].
	methodOrBlockNumTemps to: simStackPtr do:
		[:i|
		((self addressOf: simSelf) isSameEntryAs: (self simStackAt: i)) ifTrue:
			[(self simStackAt: i) liveRegister: NoReg]].
	simSelf liveRegister: NoReg