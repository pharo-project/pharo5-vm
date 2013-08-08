bytecode generators
genStorePop: popBoolean MaybeContextReceiverVariable: slotIndex
	<inline: false>
	| jmpSingle jmpDone |
	<var: #jmpSingle type: #'AbstractInstruction *'>
	<var: #jmpDone type: #'AbstractInstruction *'>
	self assert: needsFrame.
	self MoveMw: FoxMFReceiver r: FPReg R: ReceiverResultReg.
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
	traceStores > 0 ifTrue:
		[self CallRT: ceTraceStoreTrampoline].
	objectRepresentation
		genStoreSourceReg: ClassReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg.
	jmpDone jmpTarget: self Label.
	popBoolean ifTrue:
		[self AddCq: BytesPerWord R: SPReg].
	^0