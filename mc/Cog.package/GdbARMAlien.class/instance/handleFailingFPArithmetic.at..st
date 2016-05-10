error handling
handleFailingFPArithmetic: instr at: pc
	| oneRegTransferMask twoRegTransferMask |
	oneRegTransferMask := 16rF000F00.
	(instr bitAnd: oneRegTransferMask) = 16rE000B00 ifTrue:
		[^self handleOneRegTransferDoubleArithmetic: instr at: pc].
	(instr bitAnd: oneRegTransferMask) = 16rE000A00 ifTrue:
		[^self handleOneRegTransferSingleArithmetic: instr at: pc].
	twoRegTransferMask := 16rFE00FC0.
	(instr bitAnd: twoRegTransferMask) = 16rC400B00 ifTrue:
		[^self handleTwoRegTransferDoubleArithmetic: instr at: pc].
	(instr bitAnd: twoRegTransferMask) = 16rC400A00 ifTrue:
		[^self handleTwoRegTransferSingleArithmetic: instr at: pc].
	^self reportPrimitiveFailure