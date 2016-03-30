bytecode generator support
genStorePop: popBoolean RemoteTemp: slotIndex At: remoteTempIndex
	<inline: false>
	| topReg needStoreCheck |
	"The only reason we assert needsFrame here is that in a frameless method
	 ReceiverResultReg must and does contain only self, but the ceStoreCheck
	 trampoline expects the target of the store to be in ReceiverResultReg.  So
	 in a frameless method we would have a conflict between the receiver and
	 the temote temp store, unless we we smart enough to realise that
	 ReceiverResultReg was unused after the literal variable store, unlikely given
	 that methods return self by default."
	self assert: needsFrame.
	"N.B.  No need to check the stack for references because we generate code for
	 remote temp loads that stores the result in a register, deferring only the register push."
	needStoreCheck := (objectRepresentation isUnannotatableConstant: self ssTop) not.
	topReg := self allocateRegForStackEntryAt: 0 notConflictingWith: (self registerMaskFor: ReceiverResultReg).
	self ssAllocateRequiredReg: ReceiverResultReg. 
	optStatus isReceiverResultRegLive: false.
	self ssStoreAndReplacePop: popBoolean toReg: topReg.
	self MoveMw: (self frameOffsetOfTemporary: remoteTempIndex) r: FPReg R: ReceiverResultReg.
	^objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: needsFrame
		needsStoreCheck: needStoreCheck