bytecode generator stores
genStorePop: popBoolean LiteralVariable: litVarIndex needsStoreCheck: needsStoreCheck needsImmutabilityCheck: needsImmCheck
	<inline: false>
	"We need a frame because the association has to be in ReceiverResultReg for the various trampolines
	and ReceiverResultReg holds only the receiver in frameless methods."
	self assert: needsFrame.
	self genLoadLiteralVariable: litVarIndex in: ReceiverResultReg.
	^self 
		genGenericStorePop: popBoolean 
		slotIndex: ValueIndex 
		destReg: ReceiverResultReg
		needsStoreCheck: needsStoreCheck
		needsRestoreRcvr: false
		needsImmutabilityCheck: needsImmCheck
		