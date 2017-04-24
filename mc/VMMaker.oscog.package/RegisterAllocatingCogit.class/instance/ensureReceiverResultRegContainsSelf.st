bytecode generator support
ensureReceiverResultRegContainsSelf
	methodOrBlockNumTemps to: simStackPtr do:
		[:i|
		((self addressOf: simSelf) isSameEntryAs: (self simStackAt: i))
			ifTrue: [(self simStackAt: i) liveRegister: ReceiverResultReg]
			ifFalse:
				[(self simStackAt: i) liveRegister = ReceiverResultReg ifTrue:
					[(self simStackAt: i) liveRegister: NoReg]]].
	needsFrame
		ifTrue:
			[self receiverIsInReceiverResultReg ifFalse:
				[self ssAllocateRequiredReg: ReceiverResultReg.
				 self putSelfInReceiverResultReg]]
		ifFalse:
			[self assert: (simSelf type = SSRegister
						  and: [simSelf liveRegister = ReceiverResultReg])].
	self assert: self receiverIsInReceiverResultReg