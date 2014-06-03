bytecode generators
genPushReceiverVariable: index
	<inline: false>
	self ensureReceiverResultRegContainsSelf.
	^self ssPushBase: ReceiverResultReg
			offset: (objectRepresentation slotOffsetOfInstVarIndex: index)