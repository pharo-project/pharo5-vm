bytecode generator support
genStorePop: popBoolean ReceiverVariable: slotIndex
	<inline: false>
	self genStorePop: popBoolean ReceiverVariable: slotIndex needsStoreCheck: self ssTopNeedsStoreCheck.
	^ 0
		