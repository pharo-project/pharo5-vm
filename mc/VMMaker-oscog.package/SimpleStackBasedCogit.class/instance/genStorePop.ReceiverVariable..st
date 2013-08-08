bytecode generators
genStorePop: popBoolean ReceiverVariable: slotIndex
	<inline: false>
	needsFrame ifTrue:
		[self MoveMw: FoxMFReceiver r: FPReg R: ReceiverResultReg].
	popBoolean
		ifTrue: [self PopR: ClassReg]
		ifFalse: [self MoveMw: 0 r: SPReg R: ClassReg].
	traceStores > 0 ifTrue:
		[self CallRT: ceTraceStoreTrampoline].
	^objectRepresentation
		genStoreSourceReg: ClassReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg