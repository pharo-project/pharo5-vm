bytecode generator support
ensureReceiverResultRegContainsSelf
	needsFrame
		ifTrue:
			[optStatus isReceiverResultRegLive ifFalse:
				[self ssAllocateRequiredReg: ReceiverResultReg.
				self putSelfInReceiverResultReg ].
			optStatus isReceiverResultRegLive: true]
		ifFalse:
			[self assert: (simSelf type = SSRegister
						  and: [simSelf register = ReceiverResultReg]).
			self assert: (optStatus isReceiverResultRegLive
						  and: [optStatus ssEntry = (self addressOf: simSelf)])]