bytecode generators
ensureReceiverResultRegContainsSelf
	needsFrame
		ifTrue:
			[(optStatus isReceiverResultRegLive
			 and: [optStatus ssEntry = (self addressOf: simSelf)]) ifFalse:
				[self ssAllocateRequiredReg: ReceiverResultReg.
				 (self addressOf: simSelf) storeToReg: ReceiverResultReg].
			optStatus
				isReceiverResultRegLive: true;
				ssEntry: (self addressOf: simSelf)]
		ifFalse:
			[self assert: (simSelf type = SSRegister
						  and: [simSelf register = ReceiverResultReg]).
			self assert: (optStatus isReceiverResultRegLive
						  and: [optStatus ssEntry = (self addressOf: simSelf)])]