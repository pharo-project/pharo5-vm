bytecode generator support
genStorePop: popBoolean ReceiverVariable: slotIndex
	<inline: false>
	| immutabilityFailure |
	<var: #immutabilityFailure type: #'AbstractInstruction *'>
	needsFrame ifTrue:
		[self putSelfInReceiverResultReg].
	popBoolean
		ifTrue: [self PopR: ClassReg]
		ifFalse: [self MoveMw: 0 r: SPReg R: ClassReg].
	traceStores > 0 ifTrue:
		[self CallRT: ceTraceStoreTrampoline].
	self cppIf: IMMUTABILITY ifTrue: 
		[immutabilityFailure := objectRepresentation
									genImmutableCheck: ReceiverResultReg
									slotIndex: slotIndex
									sourceReg: ClassReg
									scratchReg: TempReg
									needRestoreRcvr: true].
	objectRepresentation
		genStoreSourceReg: ClassReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: needsFrame.

	self cppIf: IMMUTABILITY ifTrue:
		[immutabilityFailure jmpTarget: self Label].

	^0