bytecode generator support
genImmutabilityCheckStorePop: popBoolean MaybeContextReceiverVariable: slotIndex
	<inline: true>
	| jmpSingle jmpDone needStoreCheck |
	<var: #jmpSingle type: #'AbstractInstruction *'>
	<var: #jmpDone type: #'AbstractInstruction *'>
	"The reason we need a frame here is that assigning to an inst var of a context may
	 involve wholesale reorganization of stack pages, and the only way to preserve the
	 execution state of an activation in that case is if it has a frame."
	self assert: needsFrame.
	needStoreCheck := self ssTopNeedsStoreCheck.
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
	self ssStoreAndReplacePop: popBoolean toReg: ClassReg.
	"stack is flushed except maybe ssTop if popBoolean is false.
	  ssTop is a SSregister in this case due to #ssStoreAndReplacePop:
	  to avoid a second indirect read / annotation in case of SSConstant
	  or SSBaseRegister"
	self ssFlushTo: simStackPtr.
	jmpSingle := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self MoveCq: slotIndex R: SendNumArgsReg.
	self CallRT: ceStoreContextInstVarTrampoline.
	jmpDone := self Jump: 0.
	jmpSingle jmpTarget: self Label.
	objectRepresentation 
		genStoreWithImmutabilityCheckSourceReg: ClassReg 
		slotIndex: slotIndex 
		destReg: ReceiverResultReg 
		scratchReg: TempReg 
		needsStoreCheck: needStoreCheck 
		needRestoreRcvr: true.
	jmpDone jmpTarget: self Label.
	^0