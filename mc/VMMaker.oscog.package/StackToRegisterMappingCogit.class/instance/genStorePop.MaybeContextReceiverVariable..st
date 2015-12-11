bytecode generator support
genStorePop: popBoolean MaybeContextReceiverVariable: slotIndex
	<inline: false>
	| jmpSingle jmpDone needStoreCheck immutabilityFailure |
	<var: #jmpSingle type: #'AbstractInstruction *'>
	<var: #jmpDone type: #'AbstractInstruction *'>
	"The reason we need a frame here is that assigning to an inst var of a context may
	 involve wholesale reorganization of stack pages, and the only way to preserve the
	 execution state of an activation in that case is if it has a frame."
	self assert: needsFrame.
	self cppIf: IMMUTABILITY ifTrue: [ self ssFlushTo: simStackPtr - 1 ].
	self ssFlushUpThroughReceiverVariable: slotIndex.
	needStoreCheck := (objectRepresentation isUnannotatableConstant: self ssTop) not.
	"Note that ReceiverResultReg remains live after both
	 ceStoreContextInstVarTrampoline and ceStoreCheckTrampoline."
	self ensureReceiverResultRegContainsSelf.
	self ssPop: 1.
	self ssAllocateCallReg: ClassReg and: SendNumArgsReg. "for ceStoreContextInstVarTrampoline"
	self ssPush: 1.
	objectRepresentation
		genLoadSlot: SenderIndex
		sourceReg: ReceiverResultReg
		destReg: TempReg.
	self 
		cppIf: IMMUTABILITY
		ifTrue: [ self ssStoreAndReplacePop: popBoolean toReg: ClassReg. ]
		ifFalse: [ self ssStorePop: popBoolean toReg: ClassReg ].
	jmpSingle := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self MoveCq: slotIndex R: SendNumArgsReg.
	self CallRT: ceStoreContextInstVarTrampoline.
	jmpDone := self Jump: 0.
	jmpSingle jmpTarget: self Label.
	traceStores > 0 ifTrue:
		[self MoveR: ClassReg R: TempReg.
		 self CallRT: ceTraceStoreTrampoline].
	self 
		cppIf: IMMUTABILITY
		ifTrue: 
			[ immutabilityFailure := objectRepresentation 
				genImmutableCheck: ReceiverResultReg 
				slotIndex: ValueIndex 
				sourceReg: ClassReg 
				scratchReg: TempReg 
				popBoolean: popBoolean
				needRestoreRcvr: true ].
	objectRepresentation
		genStoreSourceReg: ClassReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: true
		needsStoreCheck: needStoreCheck.
	jmpDone jmpTarget: self Label.
	self cppIf: IMMUTABILITY ifTrue: [ immutabilityFailure jmpTarget: self Label ].
	^0