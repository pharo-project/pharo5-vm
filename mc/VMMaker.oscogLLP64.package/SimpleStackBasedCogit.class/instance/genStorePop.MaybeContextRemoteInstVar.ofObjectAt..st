bytecode generator support
genStorePop: popBoolean MaybeContextRemoteInstVar: slotIndex ofObjectAt: objectIndex
	<inline: false>
	| jmpSingle jmpDone |
	<var: #jmpSingle type: #'AbstractInstruction *'>
	<var: #jmpDone type: #'AbstractInstruction *'>
	"The reason we need a frame here is that assigning to an inst var of a context may
	 involve wholesale reorganization of stack pages, and the only way to preserve the
	 execution state of an activation in that case is if it has a frame."
	self assert: needsFrame.
	self MoveMw: (self frameOffsetOfTemporary: objectIndex) r: FPReg R: ReceiverResultReg.
	objectRepresentation 
		genEnsureOopInRegNotForwarded: ReceiverResultReg 
		scratchReg: TempReg.
	objectRepresentation
		genLoadSlot: SenderIndex
		sourceReg: ReceiverResultReg
		destReg: TempReg.
	self MoveMw: 0 r: SPReg R: ClassReg.
	jmpSingle := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self MoveCq: slotIndex R: SendNumArgsReg.
	self CallRT: ceStoreContextInstVarTrampoline.
	jmpDone := self Jump: 0.
	jmpSingle jmpTarget: self Label.
	popBoolean ifTrue:
		[self AddCq: objectMemory wordSize R: SPReg].
	self
		genStoreSourceReg: ClassReg 
		slotIndex: slotIndex 
		destReg: ReceiverResultReg 
		scratchReg: TempReg 
		inFrame: needsFrame.
	jmpDone jmpTarget: self Label.
	^0