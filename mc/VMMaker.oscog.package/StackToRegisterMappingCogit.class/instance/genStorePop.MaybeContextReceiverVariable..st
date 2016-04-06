bytecode generator support
genStorePop: popBoolean MaybeContextReceiverVariable: slotIndex 
	<inline: false>
	self genStorePop: popBoolean MaybeContextReceiverVariable: slotIndex needsStoreCheck: self ssTopNeedsStoreCheck.
	^ 0