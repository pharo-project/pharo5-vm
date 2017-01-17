bytecode generator stores
genGenericStorePop: popBoolean MaybeContextSlotIndex: slotIndex needsStoreCheck: needsStoreCheck needsRestoreRcvr: needsRestoreReceiver needsImmutabilityCheck: needsImmCheck
	"Generates a store into an object that *may* be a context.
	Multiple settings:
	- needsStoreCheck (young into old object check)
	- needRestoreRcvr (ensures the recevier is live across the store)
	- needsImmCheck (do the call-back if the receiver is immutable)"
	<inline: true>
	<var: #mutableJump type: #'AbstractInstruction *'>
	<var: #immutabilityFailure type: #'AbstractInstruction *'>
	| immutabilityFailure mutableJump |
	"The reason we need a frame here is that assigning to an inst var of a context may
	 involve wholesale reorganization of stack pages, and the only way to preserve the
	 execution state of an activation in that case is if it has a frame."
	self assert: needsFrame.
	self 
		cppIf: IMMUTABILITY
		ifTrue:
			[needsImmCheck
				ifTrue: 
					[mutableJump := objectRepresentation genJumpMutable: ReceiverResultReg scratchReg: TempReg.
					 objectRepresentation genStoreTrampolineCall: slotIndex.
					 needsRestoreReceiver ifTrue: [ self putSelfInReceiverResultReg ].
					 immutabilityFailure := self Jump: 0.
					 mutableJump jmpTarget: self Label.]].
	self ssPop: 1.
	self ssAllocateCallReg: ClassReg and: SendNumArgsReg. "for ceStoreContextInstVarTrampoline"
	self ssPush: 1.
	objectRepresentation
		genLoadSlot: SenderIndex
		sourceReg: ReceiverResultReg
		destReg: TempReg.
	self ssStoreAndReplacePop: popBoolean toReg: ClassReg.
	self ssFlushTo: simStackPtr.
	self MoveCq: slotIndex R: SendNumArgsReg.
	self CallRT: ceStoreContextInstVarTrampoline.
	self 
		cppIf: IMMUTABILITY
		ifTrue:
			[needsImmCheck ifTrue:[immutabilityFailure jmpTarget: self Label]].
	^0