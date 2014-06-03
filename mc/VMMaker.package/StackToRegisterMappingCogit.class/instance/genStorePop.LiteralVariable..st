bytecode generators
genStorePop: popBoolean LiteralVariable: litVarIndex
	<inline: false>
	| topReg valueReg association constVal |
	self flag: 'with better register allocation this wouldn''t need a frame.  e.g. use SendNumArgs instead of ReceiverResultReg'.
	self assert: needsFrame.
	optStatus isReceiverResultRegLive: false.
	"N.B.  No need to check the stack for references because we generate code for
	 literal variable loads that stores the result in a register, deferring only the register push."
	association := self getLiteral: litVarIndex.
	constVal := self ssTop maybeConstant.
	"Avoid store check for immediate values"
	(self ssTop type = SSConstant
	 and: [(objectRepresentation shouldAnnotateObjectReference: constVal) not]) ifTrue:
		[self ssAllocateRequiredReg: ReceiverResultReg.
		 self annotate: (self MoveCw: association R: ReceiverResultReg) objRef: association.
		 objectRepresentation
			genEnsureObjInRegNotForwarded: ReceiverResultReg
			scratchReg: TempReg.
		 self ssStorePop: popBoolean toPreferredReg: TempReg.
		 traceStores > 0 ifTrue:
			[self CallRT: ceTraceStoreTrampoline].
		 ^objectRepresentation
			genStoreImmediateInSourceReg: TempReg
			slotIndex: ValueIndex
			destReg: ReceiverResultReg].
	((topReg := self ssTop registerOrNil) isNil
	 or: [topReg = ReceiverResultReg]) ifTrue:
		[topReg := ClassReg].
	self ssPop: 1.
	self ssAllocateCallReg: topReg. "for the ceStoreCheck call in genStoreSourceReg:... below"
	self ssPush: 1.
	valueReg := self ssStorePop: popBoolean toPreferredReg: topReg.
	valueReg = ReceiverResultReg ifTrue:
		[self MoveR: valueReg R: topReg].
	self ssAllocateCallReg: ReceiverResultReg.
	self annotate: (self MoveCw: association R: ReceiverResultReg) objRef: association.
	objectRepresentation genEnsureObjInRegNotForwarded: ReceiverResultReg scratchReg: TempReg.
	traceStores > 0 ifTrue:
		[self MoveR: topReg R: TempReg.
		 self CallRT: ceTraceStoreTrampoline].
	^objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: ValueIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg