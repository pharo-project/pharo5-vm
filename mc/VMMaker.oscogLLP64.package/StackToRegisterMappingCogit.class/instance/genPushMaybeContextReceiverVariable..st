bytecode generator support
genPushMaybeContextReceiverVariable: slotIndex 
	<inline: false>
	self ssAllocateCallReg: ReceiverResultReg and: SendNumArgsReg.
	self ensureReceiverResultRegContainsSelf.
	^ self genPushMaybeContextSlotIndex: slotIndex