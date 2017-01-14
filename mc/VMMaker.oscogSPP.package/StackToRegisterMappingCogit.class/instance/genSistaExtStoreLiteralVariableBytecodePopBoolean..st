bytecode generators
genSistaExtStoreLiteralVariableBytecodePopBoolean: boolean
	<inline: true>
	| index needsStoreCheck needsImmCheck |
	needsStoreCheck := self sistaNeedsStoreCheck.
	needsImmCheck := self extBSpecifiesImmCheck.
	index := byte1 + (extA << 8).
	extA := numExtB := extB := 0.
	^self 
		genStorePop: boolean 
		LiteralVariable: index 
		needsStoreCheck: needsStoreCheck 
		needsImmutabilityCheck: needsImmCheck