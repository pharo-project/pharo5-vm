primitive generators
genQuickReturnInstVar
	<api> "because selected by CoInterpreter>>quickPrimitiveGeneratorFor:"
	| index |
	index := coInterpreter quickPrimitiveInstVarIndexFor: primitiveIndex.
	objectRepresentation genLoadSlot: index sourceReg: ReceiverResultReg destReg: ReceiverResultReg.
	self genUpArrowReturn.
	^UnfailingPrimitive