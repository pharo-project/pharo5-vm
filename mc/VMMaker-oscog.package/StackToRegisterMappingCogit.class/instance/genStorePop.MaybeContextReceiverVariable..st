bytecode generators
genStorePop: popBoolean MaybeContextReceiverVariable: slotIndex
	<inline: false>
	| jmpSingle jmpDone valueReg |
	<var: #jmpSingle type: #'AbstractInstruction *'>
	<var: #jmpDone type: #'AbstractInstruction *'>
	self assert: needsFrame.
	self ssFlushUpThroughReceiverVariable: slotIndex.
	"Note that ReceiverResultReg remains live after both
	 ceStoreContextInstVarTrampoline and ceStoreCheckTrampoline."
	self ensureReceiverResultRegContainsSelf.
	self ssPop: 1.
	self ssAllocateCallReg: ClassReg and: SendNumArgsReg. "for the ceStoreCheck call in genStoreSourceReg:... below"
	self ssPush: 1.
	objectRepresentation
		genLoadSlot: SenderIndex
		sourceReg: ReceiverResultReg
		destReg: TempReg.
	valueReg := self ssStorePop: popBoolean toPreferredReg: ClassReg.
	valueReg ~= ClassReg ifTrue:
		[self MoveR: valueReg R: ClassReg].
	jmpSingle := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self MoveCq: slotIndex R: SendNumArgsReg.
	self CallRT: ceStoreContextInstVarTrampoline.
	jmpDone := self Jump: 0.
	jmpSingle jmpTarget: self Label.
	traceStores > 0 ifTrue:
		[self MoveR: ClassReg R: TempReg.
		 self CallRT: ceTraceStoreTrampoline].
	objectRepresentation
		genStoreSourceReg: ClassReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg.
	jmpDone jmpTarget: self Label.
	^0