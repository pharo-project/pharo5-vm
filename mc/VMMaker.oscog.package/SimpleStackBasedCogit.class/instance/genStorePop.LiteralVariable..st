bytecode generator support
genStorePop: popBoolean LiteralVariable: litVarIndex
	<inline: false>
	| association immutabilityFailure |
	<var: #immutabilityFailure type: #'AbstractInstruction *'>
	"The only reason we assert needsFrame here is that in a frameless method
	 ReceiverResultReg must and does contain only self, but the ceStoreCheck
	 trampoline expects the target of the store to be in ReceiverResultReg.  So
	 in a frameless method we would have a conflict between the receiver and
	 the literal store, unless we we smart enough to realise that ReceiverResultReg
	 was unused after the literal variable store, unlikely given that methods
	 return self by default."
	self assert: needsFrame.
	association := self getLiteral: litVarIndex.
	self genMoveConstant: association R: ReceiverResultReg.
	objectRepresentation
		genEnsureObjInRegNotForwarded: ReceiverResultReg
		scratchReg: TempReg.
	popBoolean
		ifTrue: [self PopR: ClassReg]
		ifFalse: [self MoveMw: 0 r: SPReg R: ClassReg].
	traceStores > 0 ifTrue:
		[self CallRT: ceTraceStoreTrampoline].
	self cppIf: IMMUTABILITY ifTrue: 
		[immutabilityFailure := objectRepresentation
									genImmutableCheck: ReceiverResultReg
									slotIndex: ValueIndex
									sourceReg: ClassReg
									scratchReg: TempReg
									needRestoreRcvr: true].
	objectRepresentation
		genStoreSourceReg: ClassReg
		slotIndex: ValueIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: needsFrame.

	self cppIf: IMMUTABILITY ifTrue:
		[immutabilityFailure jmpTarget: self Label].

	^0