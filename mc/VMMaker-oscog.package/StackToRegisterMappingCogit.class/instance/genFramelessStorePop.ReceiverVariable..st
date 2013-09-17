bytecode generators
genFramelessStorePop: popBoolean ReceiverVariable: slotIndex
	<inline: false>
	| topReg valueReg constVal |
	self assert: needsFrame not.
	self ssFlushUpThroughReceiverVariable: slotIndex.
	"Avoid store check for immediate values"
	constVal := self ssTop maybeConstant.
	(self ssTop type = SSConstant
	 and: [(objectRepresentation shouldAnnotateObjectReference: constVal) not]) ifTrue:
		[self ensureReceiverResultRegContainsSelf.
		 self ssStorePop: popBoolean toPreferredReg: TempReg.
		 traceStores > 0 ifTrue:
			[self CallRT: ceTraceStoreTrampoline].
		 ^objectRepresentation
			genStoreImmediateInSourceReg: TempReg
			slotIndex: slotIndex
			destReg: ReceiverResultReg].
	(topReg := self ssTop registerOrNil) isNil ifTrue:
		[topReg := ClassReg].
	valueReg := self ssStorePop: popBoolean toPreferredReg: topReg.
	"Note that ReceiverResultReg remains live after ceStoreCheckTrampoline."
	self ensureReceiverResultRegContainsSelf.
	 traceStores > 0 ifTrue:
		[self MoveR: valueReg R: TempReg.
		 self CallRT: ceTraceStoreTrampoline].
	^objectRepresentation
		genStoreSourceReg: valueReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg