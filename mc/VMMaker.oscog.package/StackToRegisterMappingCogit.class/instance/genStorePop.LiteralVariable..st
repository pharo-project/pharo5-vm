bytecode generator support
genStorePop: popBoolean LiteralVariable: litVarIndex
	<inline: false>
	| topReg association needStoreCheck immutabilityFailure |
	"The only reason we assert needsFrame here is that in a frameless method
	 ReceiverResultReg must and does contain only self, but the ceStoreCheck
	 trampoline expects the target of the store to be in ReceiverResultReg.  So
	 in a frameless method we would have a conflict between the receiver and
	 the literal store, unless we we smart enough to realise that ReceiverResultReg
	 was unused after the literal variable store, unlikely given that methods
	 return self by default."
	self assert: needsFrame.
	self cppIf: IMMUTABILITY ifTrue: [ self ssFlushTo: simStackPtr - 1 ].
	"N.B.  No need to check the stack for references because we generate code for
	 literal variable loads that stores the result in a register, deferring only the register push."
	needStoreCheck := (objectRepresentation isUnannotatableConstant: self ssTop) not.
	association := self getLiteral: litVarIndex.
	optStatus isReceiverResultRegLive: false.
	self ssAllocateRequiredReg: ReceiverResultReg. "for ceStoreCheck call in genStoreSourceReg: has to be ReceiverResultReg"
	self genMoveConstant: association R: ReceiverResultReg.
	objectRepresentation genEnsureObjInRegNotForwarded: ReceiverResultReg scratchReg: TempReg.
	self 
		cppIf: IMMUTABILITY
		ifTrue: 
			[ self ssAllocateRequiredReg: ClassReg.
			  topReg := ClassReg.
			  self ssStoreAndReplacePop: popBoolean toReg: ClassReg.
			  "stack is flushed except maybe ssTop if popBoolean is false.
			  ssTop is a SSregister in this case due to #ssStoreAndReplacePop:
			  to avoid a second indirect read / annotation in case of SSConstant
			  or SSBaseRegister"
			  self ssFlushTo: simStackPtr.
			  immutabilityFailure := objectRepresentation
										genImmutableCheck: ReceiverResultReg
										slotIndex: ValueIndex
										sourceReg: ClassReg
										scratchReg: TempReg
										needRestoreRcvr: false ]
		ifFalse: 
			[ topReg := self allocateRegForStackEntryAt: 0 notConflictingWith: (self registerMaskFor: ReceiverResultReg).
			  self ssStorePop: popBoolean toReg: topReg ].
	traceStores > 0 ifTrue:
		[self MoveR: topReg R: TempReg.
		 self CallRT: ceTraceStoreTrampoline].
	objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: ValueIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: needsFrame
		needsStoreCheck: needStoreCheck.
	self cppIf: IMMUTABILITY ifTrue: [ immutabilityFailure jmpTarget: self Label ].
	^ 0