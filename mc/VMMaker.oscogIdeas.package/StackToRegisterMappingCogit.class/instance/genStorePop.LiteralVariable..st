bytecode generator stores
genStorePop: popBoolean LiteralVariable: litVarIndex
	<inline: true>
	^self 
		genStorePop: popBoolean 
		LiteralVariable: litVarIndex 
		needsStoreCheck: self ssTopNeedsStoreCheck
		needsImmutabilityCheck: true "The generic store checks for IMMUTABILITY flag"
		