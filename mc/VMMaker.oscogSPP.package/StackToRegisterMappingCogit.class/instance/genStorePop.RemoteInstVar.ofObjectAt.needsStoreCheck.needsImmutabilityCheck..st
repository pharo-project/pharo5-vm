bytecode generator stores
genStorePop: popBoolean RemoteInstVar: slotIndex ofObjectAt: objectIndex needsStoreCheck: needsStoreCheck needsImmutabilityCheck: needsImmCheck
	<inline: false>
	self assert: needsFrame.
	self genLoadTemp: objectIndex in: ReceiverResultReg.
	^self 
		genGenericStorePop: popBoolean 
		slotIndex: slotIndex 
		destReg: ReceiverResultReg 
		needsStoreCheck: needsStoreCheck
		needsRestoreRcvr: false
		needsImmutabilityCheck: needsImmCheck