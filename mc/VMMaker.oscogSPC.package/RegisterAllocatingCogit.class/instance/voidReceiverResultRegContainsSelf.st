bytecode generator support
voidReceiverResultRegContainsSelf
	"Used when ReceiverResultReg is allocated for other than simSelf, and
	 there may be references to ReceiverResultReg which need to be spilled."
	self assert: (simSelf liveRegister = ReceiverResultReg) = optStatus isReceiverResultRegLive.
	optStatus isReceiverResultRegLive ifFalse:
		[self deny: self simSelfOnStackInReceiverResultReg.
		 ^self].
	optStatus isReceiverResultRegLive: false.
	methodOrBlockNumTemps to: simStackPtr do:
		[:i|
		((self addressOf: simSelf) isSameEntryAs: (self simStackAt: i)) ifTrue:
			[(self simStackAt: i) liveRegister: NoReg]].
	simSelf liveRegister: NoReg