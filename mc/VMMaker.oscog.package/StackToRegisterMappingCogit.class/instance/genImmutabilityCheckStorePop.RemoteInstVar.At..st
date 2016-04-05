bytecode generator support
genImmutabilityCheckStorePop: popBoolean RemoteInstVar: slotIndex At: objectIndex 
	<inline: true>
	| needStoreCheck |
	self assert: needsFrame. 
	needStoreCheck := self ssTopNeedsStoreCheck.
	
	self ssAllocateRequiredReg: ReceiverResultReg. 
	optStatus isReceiverResultRegLive: false.
	self MoveMw: (self frameOffsetOfTemporary: objectIndex) r: FPReg R: ReceiverResultReg.
	
	self ssAllocateRequiredReg: ClassReg.
	self ssStoreAndReplacePop: popBoolean toReg: ClassReg.
	self ssFlushTo: simStackPtr.
	
	objectRepresentation 
		genEnsureOopInRegNotForwarded: ReceiverResultReg 
		scratchReg: TempReg.
	
	objectRepresentation 
		genStoreWithImmutabilityCheckSourceReg: ClassReg 
		slotIndex: slotIndex 
		destReg: ReceiverResultReg 
		scratchReg: TempReg 
		needsStoreCheck: needStoreCheck 
		needRestoreRcvr: false.
	^ 0