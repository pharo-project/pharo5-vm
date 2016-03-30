bytecode generator support
genStorePop: popBoolean ReceiverVariable: slotIndex
	<inline: false>
	needsFrame ifTrue:
		[self putSelfInReceiverResultReg].
	popBoolean
		ifTrue: [self PopR: ClassReg]
		ifFalse: [self MoveMw: 0 r: SPReg R: ClassReg].
	self
		genStoreSourceReg: ClassReg 
		slotIndex: slotIndex 
		destReg: ReceiverResultReg 
		scratchReg: TempReg 
		inFrame: needsFrame.
	^0