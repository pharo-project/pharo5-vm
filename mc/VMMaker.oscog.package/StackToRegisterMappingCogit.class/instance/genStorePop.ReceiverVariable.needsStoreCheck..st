bytecode generator support
genStorePop: popBoolean ReceiverVariable: slotIndex needsStoreCheck: needsStoreCheck
	<inline: false>
	self ssFlushUpThroughReceiverVariable: slotIndex.
	self ensureReceiverResultRegContainsSelf.
	self 
		genStorePop: popBoolean 
		slotIndex: slotIndex 
		destReg: ReceiverResultReg 
		needsStoreCheck: needsStoreCheck
		needsRestoreRcvr: true.
	^ 0
		