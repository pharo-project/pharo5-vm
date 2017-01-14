bytecode generator support
genPushMaybeContextRemoteInstVar: slotIndex inObjectAt: index
	<inline: false>
	self ssAllocateCallReg: ReceiverResultReg and: SendNumArgsReg.
	self genLoadTemp: index in: ReceiverResultReg.
	^ self genPushMaybeContextSlotIndex: slotIndex