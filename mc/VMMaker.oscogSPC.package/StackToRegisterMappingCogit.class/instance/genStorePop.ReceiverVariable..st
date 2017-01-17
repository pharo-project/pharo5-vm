bytecode generator stores
genStorePop: popBoolean ReceiverVariable: slotIndex
	<inline: true>
	^self 
		genStorePop: popBoolean 
		ReceiverVariable: slotIndex 
		needsStoreCheck: self ssTopNeedsStoreCheck
		needsImmutabilityCheck: true "The generic store checks for IMMUTABILITY flag"
		