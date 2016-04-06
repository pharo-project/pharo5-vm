bytecode generator support
genStorePop: popBoolean LiteralVariable: litVarIndex needsStoreCheck: needsStoreCheck
	<inline: false>
	"We need a frame because the association has to be in ReceiverResultReg for the various trampolines
	and ReceiverResultReg holds only the receiver in frameless methods."
	self assert: needsFrame.
	self genLoadLiteralVariable: litVarIndex in: ReceiverResultReg.
	self 
		genStorePop: popBoolean 
		slotIndex: ValueIndex 
		destReg: ReceiverResultReg
		needsStoreCheck: needsStoreCheck
		needsRestoreRcvr: false.
	^ 0
		