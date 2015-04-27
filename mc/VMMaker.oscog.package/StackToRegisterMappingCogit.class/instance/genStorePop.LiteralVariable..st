bytecode generator support
genStorePop: popBoolean LiteralVariable: litVarIndex
	<inline: false>
	| topReg assocReg association |
	"N.B.  No need to check the stack for references because we generate code for
	 literal variable loads that stores the result in a register, deferring only the register push."
	association := self getLiteral: litVarIndex.
	
	"Avoid store check for immediate values"
	(objectRepresentation isUnannotatableConstant: self ssTop) 
		ifTrue:
			[ assocReg := self allocateAnyReg.
			self genMoveConstant: association R: assocReg.
			 objectRepresentation
				genEnsureObjInRegNotForwarded: assocReg
				scratchReg: TempReg.
			self ssStorePop: popBoolean toReg: TempReg.
			 traceStores > 0 ifTrue:
				[ assocReg = ReceiverResultReg ifFalse: 
					[ self ssAllocateRequiredReg: ReceiverResultReg.
					optStatus isReceiverResultRegLive: false.
					self MoveR: assocReg R: ReceiverResultReg ].
				self CallRT: ceTraceStoreTrampoline].
			 ^objectRepresentation
				genStoreImmediateInSourceReg: TempReg
				slotIndex: ValueIndex
				destReg: assocReg ]
			ifFalse: [ self assert: needsFrame. "because ReceiverResult reg is used for storeCheckTrampoline" ].
		
		
	topReg := self allocateRegForStackTopEntryNotConflictingWith: (self registerMaskFor: ReceiverResultReg).
	self ssPop: 1.
	self ssAllocateCallReg: topReg. "for the ceStoreCheck call in genStoreSourceReg:... below"
	self ssPush: 1.
	self ssStorePop: popBoolean toReg: topReg.
	optStatus isReceiverResultRegLive: false.
	self ssAllocateCallReg: ReceiverResultReg. "for ceStoreCheck call in genStoreSourceReg: has to be ReceiverResultReg"
	self genMoveConstant: association R: ReceiverResultReg.
	objectRepresentation genEnsureObjInRegNotForwarded: ReceiverResultReg scratchReg: TempReg.
	traceStores > 0 ifTrue:
		[self MoveR: topReg R: TempReg.
		 self CallRT: ceTraceStoreTrampoline].
	^objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: ValueIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: needsFrame