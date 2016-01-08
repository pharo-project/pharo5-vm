primitive generators
genQuickReturnConst
	<api> "because selected by CoInterpreter>>quickPrimitiveGeneratorFor:"
	| constant |
	constant := coInterpreter quickPrimitiveConstantFor: primitiveIndex.
	self annotate:
			((objectRepresentation isImmediate: constant)
				ifTrue: [self MoveCq: constant R: ReceiverResultReg]
				ifFalse: [self MoveCw: constant R: ReceiverResultReg])
		objRef: constant.
	self genUpArrowReturn.
	^UnfailingPrimitive