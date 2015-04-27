bytecode generator support
genStorePop: popBoolean ReceiverVariable: slotIndex
	<inline: false>
	| topReg valueReg |
	needsFrame ifFalse:
		[^self genFramelessStorePop: popBoolean ReceiverVariable: slotIndex].
	self ssFlushUpThroughReceiverVariable: slotIndex.
	"Avoid store check for immediate values"
	(objectRepresentation isUnannotatableConstant: self ssTop) ifTrue:
		[self ensureReceiverResultRegContainsSelf.
		 self ssStorePop: popBoolean toPreferredReg: TempReg.
		 traceStores > 0 ifTrue:
			[self CallRT: ceTraceStoreTrampoline].
		 ^objectRepresentation
			genStoreImmediateInSourceReg: TempReg
			slotIndex: slotIndex
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
	"Note that ReceiverResultReg remains live after ceStoreCheckTrampoline."
	self ensureReceiverResultRegContainsSelf.
	 traceStores > 0 ifTrue:
		[self MoveR: topReg R: TempReg.
		 self CallRT: ceTraceStoreTrampoline].
	^objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: true