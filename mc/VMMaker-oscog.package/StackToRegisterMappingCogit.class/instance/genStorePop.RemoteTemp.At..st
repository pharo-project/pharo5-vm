bytecode generators
genStorePop: popBoolean RemoteTemp: slotIndex At: remoteTempIndex
	<inline: false>
	| topReg valueReg constVal topSpilled |
	self assert: needsFrame.
	optStatus isReceiverResultRegLive: false.
	"N.B.  No need to check the stack for references because we generate code for
	 remote temp loads that stores the result in a register, deferring only the register push."
	"Avoid store check for immediate values"
	constVal := self ssTop maybeConstant.
	(self ssTop type = SSConstant
	 and: [(objectRepresentation shouldAnnotateObjectReference: constVal) not]) ifTrue:
		[self ssAllocateRequiredReg: ReceiverResultReg.
		 self MoveMw: (self frameOffsetOfTemporary: remoteTempIndex) r: FPReg R: ReceiverResultReg.
		 self ssStorePop: popBoolean toPreferredReg: TempReg.
		 traceStores > 0 ifTrue:
			[self CallRT: ceTraceStoreTrampoline].
		 ^objectRepresentation
			genStoreImmediateInSourceReg: TempReg
			slotIndex: slotIndex
			destReg: ReceiverResultReg].
	((topReg := self ssTop registerOrNil) isNil
	 or: [topReg = ReceiverResultReg]) ifTrue:
		[topReg := ClassReg].
	self ssPop: 1.
	"for the ceStoreCheck call in genStoreSourceReg:... below"
	self ssAllocateCallReg: topReg and: ReceiverResultReg.
	self ssPush: 1.
	topSpilled := self ssTop spilled.
	valueReg := self ssStorePop: (popBoolean or: [topSpilled]) toPreferredReg: topReg.
	valueReg = ReceiverResultReg ifTrue:
		[self MoveR: valueReg R: topReg].
	popBoolean ifFalse:
		[topSpilled ifFalse: [self ssPop: 1].
		 self ssPushRegister: topReg].
	self MoveMw: (self frameOffsetOfTemporary: remoteTempIndex) r: FPReg R: ReceiverResultReg.
	 traceStores > 0 ifTrue:
		[self MoveR: topReg R: TempReg.
		 self CallRT: ceTraceStoreTrampoline].
	^objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg