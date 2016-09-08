primitive generators
genQuickReturnConst
	<api> "because selected by CoInterpreter>>quickPrimitiveGeneratorFor:"
	| constant |
	constant := coInterpreter quickPrimitiveConstantFor: primitiveIndex.
	self genMoveConstant: constant R: ReceiverResultReg.
	self genUpArrowReturn.
	^UnfailingPrimitive