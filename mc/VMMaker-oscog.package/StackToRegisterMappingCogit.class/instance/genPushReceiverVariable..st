bytecode generators
genPushReceiverVariable: index
	<inline: false>
	self ensureReceiverResultRegContainsSelf.
	^objectRepresentation genSSPushSlot: index reg: ReceiverResultReg