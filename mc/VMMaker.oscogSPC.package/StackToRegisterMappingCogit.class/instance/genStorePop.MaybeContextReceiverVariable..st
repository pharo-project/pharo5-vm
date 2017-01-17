bytecode generator stores
genStorePop: popBoolean MaybeContextReceiverVariable: slotIndex 
	<inline: true>
	^self 
		genStorePop: popBoolean 
		MaybeContextReceiverVariable: slotIndex 
		needsStoreCheck: self ssTopNeedsStoreCheck
		needsImmutabilityCheck: true "The generic store checks for IMMUTABILITY flag"