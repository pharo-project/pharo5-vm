bytecode generators
genSistaExtStoreLiteralVariableBytecodePopBoolean: boolean
	<inline: true>
	| index needsStoreCheck |
	needsStoreCheck := self sistaNeedsStoreCheck and: [self ssTopNeedsStoreCheck].
	index := byte1 + (extA << 8).
	extA := extB := 0.
	^self genStorePop: boolean LiteralVariable: index needsStoreCheck: needsStoreCheck