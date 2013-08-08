bytecode generators
genStorePop: popBoolean RemoteTemp: slotIndex At: remoteTempIndex
	<inline: false>
	self assert: needsFrame.
	popBoolean
		ifTrue: [self PopR: ClassReg]
		ifFalse: [self MoveMw: 0 r: SPReg R: ClassReg].
	self MoveMw: (self frameOffsetOfTemporary: remoteTempIndex) r: FPReg R: ReceiverResultReg.
	traceStores > 0 ifTrue:
		[self CallRT: ceTraceStoreTrampoline].
	^objectRepresentation
		genStoreSourceReg: ClassReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg