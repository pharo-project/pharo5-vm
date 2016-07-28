bytecode generator stores
genStorePop: popBoolean MaybeContextReceiverVariable: slotIndex needsStoreCheck: needsStoreCheck needsImmutabilityCheck: needsImmCheck
	<inline: false>
	"The reason we need a frame here is that assigning to an inst var of a context may
	 involve wholesale reorganization of stack pages, and the only way to preserve the
	 execution state of an activation in that case is if it has a frame."
	self assert: needsFrame.
	self ssFlushUpThroughReceiverVariable: slotIndex.
	self ensureReceiverResultRegContainsSelf.
	^self 
		genGenericStorePop: popBoolean 
		MaybeContextSlotIndex: slotIndex 
		needsStoreCheck: needsStoreCheck
		needsRestoreRcvr: true
		needsImmutabilityCheck: needsImmCheck