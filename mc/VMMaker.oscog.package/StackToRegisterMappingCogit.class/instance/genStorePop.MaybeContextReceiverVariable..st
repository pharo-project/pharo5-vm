bytecode generator stores
genStorePop: popBoolean MaybeContextReceiverVariable: slotIndex 
	<inline: false>
	^self 
		genStorePop: popBoolean 
		MaybeContextReceiverVariable: slotIndex 
		needsStoreCheck: self ssTopNeedsStoreCheck
		needsImmutabilityCheck: true "The generic store checks for IMMUTABILITY flag"