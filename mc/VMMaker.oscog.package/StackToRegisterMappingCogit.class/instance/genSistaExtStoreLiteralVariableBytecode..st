bytecode generators
genSistaExtStoreLiteralVariableBytecode: boolean
	| index needsStoreCheck |
	needsStoreCheck := self sistaNeedsStoreCheck.
	extB := 0.
	index := byte1 + (extA << 8).
	extA := 0.
	^ self genStorePop: boolean LiteralVariable: index needsStoreCheck: needsStoreCheck