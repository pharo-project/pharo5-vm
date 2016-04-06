bytecode generator support
genVanillaStorePop: popBoolean MaybeContextSlotIndex: slotIndex needsStoreCheck: needsStoreCheck
	<inline: true>
	| jmpSingle jmpDone |
	<var: #jmpSingle type: #'AbstractInstruction *'>
	<var: #jmpDone type: #'AbstractInstruction *'>

	self ssPop: 1.
	self ssAllocateCallReg: ClassReg and: SendNumArgsReg. "for ceStoreContextInstVarTrampoline"
	self ssPush: 1.
	objectRepresentation
		genLoadSlot: SenderIndex
		sourceReg: ReceiverResultReg
		destReg: TempReg.
	self ssStorePop: popBoolean toReg: ClassReg.
	jmpSingle := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self MoveCq: slotIndex R: SendNumArgsReg.
	self CallRT: ceStoreContextInstVarTrampoline.
	jmpDone := self Jump: 0.
	jmpSingle jmpTarget: self Label.
	objectRepresentation
		genStoreSourceReg: ClassReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: true
		needsStoreCheck: needsStoreCheck.
	jmpDone jmpTarget: self Label.
	
	^0