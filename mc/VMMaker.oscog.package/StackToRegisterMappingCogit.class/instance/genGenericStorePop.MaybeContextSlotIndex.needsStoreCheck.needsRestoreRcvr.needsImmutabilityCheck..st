bytecode generator stores
genGenericStorePop: popBoolean MaybeContextSlotIndex: slotIndex needsStoreCheck: needsStoreCheck needsRestoreRcvr: needsRestoreReceiver needsImmutabilityCheck: needsImmCheck
	"Generates a store into an object that *may* be a context.
	Multiple settings:
	- needsStoreCheck (young into old object check)
	- needRestoreRcvr (ensures the recevier is live across the store)
	- needsImmCheck (do the call-back if the receiver is immutable)"
	<inline: true>
	| jmpSingle jmpDone |
	<var: #jmpSingle type: #'AbstractInstruction *'>
	<var: #jmpDone type: #'AbstractInstruction *'>
	"The reason we need a frame here is that assigning to an inst var of a context may
	 involve wholesale reorganization of stack pages, and the only way to preserve the
	 execution state of an activation in that case is if it has a frame."
	"Context stores do not require Imm checks as contexts can't be immutable"
	self assert: needsFrame.
	self ssPop: 1.
	self ssAllocateCallReg: ClassReg and: SendNumArgsReg. "for ceStoreContextInstVarTrampoline"
	self ssPush: 1.
	objectRepresentation
		genLoadSlot: SenderIndex
		sourceReg: ReceiverResultReg
		destReg: TempReg.
	self ssStoreAndReplacePop: popBoolean toReg: ClassReg.
	jmpSingle := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self MoveCq: slotIndex R: SendNumArgsReg.
	self CallRT: ceStoreContextInstVarTrampoline.
	jmpDone := self Jump: 0.
	jmpSingle jmpTarget: self Label.
	self 
		cppIf: IMMUTABILITY
		ifTrue:
			[needsImmCheck
				ifTrue: 
					[objectRepresentation 
						genStoreWithImmutabilityCheckSourceReg: ClassReg 
						slotIndex: slotIndex 
						destReg: ReceiverResultReg 
						scratchReg: TempReg 
						needsStoreCheck: needsStoreCheck 
						needRestoreRcvr: needsRestoreReceiver.
					jmpDone jmpTarget: self Label.
					^0]].
	objectRepresentation
			genStoreSourceReg: ClassReg
			slotIndex: slotIndex
			destReg: ReceiverResultReg
			scratchReg: TempReg
			inFrame: true
			needsStoreCheck: needsStoreCheck.
	jmpDone jmpTarget: self Label.
	^0