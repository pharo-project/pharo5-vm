bytecode generator support
genStorePop: popBoolean RemoteInstVar: slotIndex ofObjectAt: objectIndex
	<inline: false>
	"The only reason we assert needsFrame here is that in a frameless method
	 ReceiverResultReg must and does contain only self, but the ceStoreCheck
	 trampoline expects the target of the store to be in ReceiverResultReg.  So
	 in a frameless method we would have a conflict between the receiver and
	 the temote temp store, unless we we smart enough to realise that
	 ReceiverResultReg was unused after the literal variable store, unlikely given
	 that methods return self by default."
	self assert: needsFrame.
	popBoolean
		ifTrue: [self PopR: ClassReg]
		ifFalse: [self MoveMw: 0 r: SPReg R: ClassReg].
	self MoveMw: (self frameOffsetOfTemporary: objectIndex) r: FPReg R: ReceiverResultReg.
	objectRepresentation 
		genEnsureOopInRegNotForwarded: ReceiverResultReg 
		scratchReg: TempReg.
	^objectRepresentation
		genStoreSourceReg: ClassReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: needsFrame