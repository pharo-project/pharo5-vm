bytecode generator support
ensureReceiverResultRegContainsSelf
	super ensureReceiverResultRegContainsSelf.
	methodOrBlockNumTemps to: simStackPtr do:
		[:i|
		((self addressOf: simSelf) isSameEntryAs: (self simStackAt: i))
			ifTrue: [(self simStackAt: i) liveRegister: ReceiverResultReg]
			ifFalse:
				[(self simStackAt: i) liveRegister = ReceiverResultReg ifTrue:
					[(self simStackAt: i) liveRegister: NoReg]]].
	simSelf liveRegister: ReceiverResultReg