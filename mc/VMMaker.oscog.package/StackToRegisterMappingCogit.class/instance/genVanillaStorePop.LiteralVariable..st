bytecode generator support
genVanillaStorePop: popBoolean LiteralVariable: litVarIndex 
	<inline: true>
	| topReg association needStoreCheck |
	"The only reason we assert needsFrame here is that in a frameless method
	 ReceiverResultReg must and does contain only self, but the ceStoreCheck
	 trampoline expects the target of the store to be in ReceiverResultReg.  So
	 in a frameless method we would have a conflict between the receiver and
	 the literal store, unless we we smart enough to realise that ReceiverResultReg
	 was unused after the literal variable store, unlikely given that methods
	 return self by default."
	self assert: needsFrame.
	"N.B.  No need to check the stack for references because we generate code for
	 literal variable loads that stores the result in a register, deferring only the register push."
	needStoreCheck := self ssTopNeedsStoreCheck.
	association := self getLiteral: litVarIndex.
	optStatus isReceiverResultRegLive: false.
	self ssAllocateRequiredReg: ReceiverResultReg. "for ceStoreCheck call in genStoreSourceReg: has to be ReceiverResultReg"
	self genMoveConstant: association R: ReceiverResultReg.
	objectRepresentation genEnsureObjInRegNotForwarded: ReceiverResultReg scratchReg: TempReg.
	topReg := self allocateRegForStackEntryAt: 0 notConflictingWith: (self registerMaskFor: ReceiverResultReg).
	self ssStorePop: popBoolean toReg: topReg.
	objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: ValueIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: needsFrame
		needsStoreCheck: needStoreCheck.
	^ 0