bytecode generator support
genStorePop: popBoolean MaybeContextRemoteInstVar: slotIndex ofObjectAt: objectIndex needsStoreCheck: needsStoreCheck
	<inline: false>
	"The reason we need a frame here is that assigning to an inst var of a context may
	 involve wholesale reorganization of stack pages, and the only way to preserve the
	 execution state of an activation in that case is if it has a frame."
	self assert: needsFrame.
	self genLoadUnFwdTemp: objectIndex in: ReceiverResultReg.
	self genStorePop: popBoolean MaybeContextSlotIndex: slotIndex needsStoreCheck: needsStoreCheck.
	^ 0