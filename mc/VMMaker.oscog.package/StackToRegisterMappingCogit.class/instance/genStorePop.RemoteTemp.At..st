bytecode generator support
genStorePop: popBoolean RemoteTemp: slotIndex At: remoteTempIndex
	<inline: false>
	| topReg topSpilled tempVectReg |
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
	"Avoid store check for immediate values"
	(objectRepresentation isUnannotatableConstant: self ssTop) ifTrue:
		[ tempVectReg := self allocateRegNotConflictingWith: 0.
		 self MoveMw: (self frameOffsetOfTemporary: remoteTempIndex) r: FPReg R: tempVectReg.
		 self ssStorePop: popBoolean toReg: TempReg.
		 traceStores > 0 ifTrue:
			[ tempVectReg = ReceiverResultReg ifFalse: 
					[ self ssAllocateRequiredReg: ReceiverResultReg.
					optStatus isReceiverResultRegLive: false.
					self MoveR: tempVectReg R: ReceiverResultReg ].
			self CallRT: ceTraceStoreTrampoline].
		 ^objectRepresentation
			genStoreImmediateInSourceReg: TempReg
			slotIndex: slotIndex
			destReg: tempVectReg].
	topReg := self allocateRegForStackEntryAt: 0 notConflictingWith: (self registerMaskFor: ReceiverResultReg).
	topSpilled := self ssTop spilled.
	self ssStorePop: (popBoolean or: [topSpilled]) toReg: topReg.
	popBoolean ifFalse:
		[topSpilled ifFalse: [self ssPop: 1].
		 self ssPushRegister: topReg].
	self ssAllocateRequiredReg: ReceiverResultReg.
	optStatus isReceiverResultRegLive: false.
	self MoveMw: (self frameOffsetOfTemporary: remoteTempIndex) r: FPReg R: ReceiverResultReg.
	 traceStores > 0 ifTrue:
		[self MoveR: topReg R: TempReg.
		 self CallRT: ceTraceStoreTrampoline].
	^objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: needsFrame