bytecode generator support
genStorePop: popBoolean RemoteInstVar: slotIndex ofObjectAt: objectIndex needsStoreCheck: needsStoreCheck
	<inline: false>
	self assert: needsFrame.
	self genLoadUnFwdTemp: objectIndex in: ReceiverResultReg.
	self 
		genStorePop: popBoolean 
		slotIndex: slotIndex 
		destReg: ReceiverResultReg 
		needsStoreCheck: needsStoreCheck
		needsRestoreRcvr: false.
	^ 0