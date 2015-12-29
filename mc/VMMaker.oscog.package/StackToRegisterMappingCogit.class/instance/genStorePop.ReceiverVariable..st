bytecode generator support
genStorePop: popBoolean ReceiverVariable: slotIndex
	<inline: false>
	| topReg needStoreCheck immutabilityFailure |
	self cppIf: IMMUTABILITY ifTrue: [ self assert: needsFrame. self ssFlushTo: simStackPtr - 1 ].
	self ssFlushUpThroughReceiverVariable: slotIndex.
	needStoreCheck := (objectRepresentation isUnannotatableConstant: self ssTop) not.
	"Note that ReceiverResultReg remains live after ceStoreCheckTrampoline."
	self ensureReceiverResultRegContainsSelf.
	self 
		cppIf: IMMUTABILITY
		ifTrue: 
			[ self ssAllocateRequiredReg: ClassReg.
			  topReg := ClassReg.
			  self ssStoreAndReplacePop: popBoolean toReg: topReg.
			  immutabilityFailure := objectRepresentation 
				genImmutableCheck: ReceiverResultReg 
				slotIndex: slotIndex 
				sourceReg: ClassReg 
				scratchReg: TempReg
				popBoolean: popBoolean
				needRestoreRcvr: true ]
		ifFalse: 
			[ topReg := self allocateRegForStackEntryAt: 0 notConflictingWith: (self registerMaskFor: ReceiverResultReg). 
			  self ssStorePop: popBoolean toReg: topReg ].
	traceStores > 0 ifTrue: 
		[ self MoveR: topReg R: TempReg.
		self evaluateTrampolineCallBlock: [ self CallRT: ceTraceStoreTrampoline ] protectLinkRegIfNot: needsFrame ].
	objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: needsFrame
		needsStoreCheck: needStoreCheck.
	self cppIf: IMMUTABILITY ifTrue: [ immutabilityFailure jmpTarget: self Label ].
	^ 0