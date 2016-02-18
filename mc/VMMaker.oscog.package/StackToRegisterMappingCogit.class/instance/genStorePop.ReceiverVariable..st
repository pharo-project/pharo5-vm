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
			  self ssStoreAndReplacePop: popBoolean toReg: ClassReg.
			  "stack is flushed except maybe ssTop if popBoolean is false.
			  ssTop is a SSregister in this case due to #ssStoreAndReplacePop:
			  to avoid a second indirect read / annotation in case of SSConstant
			  or SSBaseRegister"
			  self ssFlushTo: simStackPtr.
			  immutabilityFailure := objectRepresentation
										genImmutableCheck: ReceiverResultReg
										slotIndex: slotIndex
										sourceReg: ClassReg
										scratchReg: TempReg
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