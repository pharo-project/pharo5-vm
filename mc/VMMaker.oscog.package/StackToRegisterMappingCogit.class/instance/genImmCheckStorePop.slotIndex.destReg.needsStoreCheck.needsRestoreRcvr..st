bytecode generator support
genImmCheckStorePop: popBoolean slotIndex: slotIndex destReg: destReg needsStoreCheck: needsStoreCheck needsRestoreRcvr: needsRestoreReceiver
	<inline: true>
	self ssAllocateRequiredReg: ClassReg.
	"we replace the top value for the flush"
	self ssStoreAndReplacePop: popBoolean toReg: ClassReg.
	self ssFlushTo: simStackPtr.
	objectRepresentation 
		genStoreWithImmutabilityCheckSourceReg: ClassReg 
		slotIndex: slotIndex 
		destReg: destReg 
		scratchReg: TempReg 
		needsStoreCheck: needsStoreCheck 
		needRestoreRcvr: needsRestoreReceiver.