bytecode generator support
genStorePop: popBoolean ReceiverVariable: slotIndex traceBlock: block inFrame: inFrame
	<inline: true>
	| topReg |
	self ssFlushUpThroughReceiverVariable: slotIndex.
	"Avoid store check for immediate values"
	(objectRepresentation isUnannotatableConstant: self ssTop) ifTrue:
		[self ensureReceiverResultRegContainsSelf.
		 self ssStorePop: popBoolean toReg: TempReg.
		 traceStores > 0 ifTrue: [block value].
		 ^objectRepresentation
			genStoreImmediateInSourceReg: TempReg
			slotIndex: slotIndex
			destReg: ReceiverResultReg].
	topReg := self allocateRegForStackEntryAt: 0 notConflictingWith: (self registerMaskFor: ReceiverResultReg).
	self ssStorePop: popBoolean toReg: topReg.
	"Note that ReceiverResultReg remains live after ceStoreCheckTrampoline."
	self ensureReceiverResultRegContainsSelf.
	 traceStores > 0 ifTrue:
		[self MoveR: topReg R: TempReg.
		 block value].
	^objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: inFrame