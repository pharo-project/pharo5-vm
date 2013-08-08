primitive generators
genQuickReturnConst
	<api> "because selected by CoInterpreter>>quickPrimitiveGeneratorFor:"
	| constant |
	constant := coInterpreter quickPrimitiveConstantFor: primitiveIndex.
	self annotate:
			(self gen: ((objectRepresentation isImmediate: constant)
						ifTrue: [MoveCqR]
						ifFalse: [MoveCwR])
				operand: constant
				operand: ReceiverResultReg)
		objRef: constant.
	^self genUpArrowReturn