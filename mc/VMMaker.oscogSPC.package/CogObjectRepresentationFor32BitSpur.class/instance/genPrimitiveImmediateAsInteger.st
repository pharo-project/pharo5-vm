primitive generators
genPrimitiveImmediateAsInteger
	":Assume the receiuver is never a SmallInteger.  One would use ^self for that."
	self genConvertCharacterToSmallIntegerInReg: ReceiverResultReg.
	cogit genPrimReturn.
	^UnfailingPrimitive