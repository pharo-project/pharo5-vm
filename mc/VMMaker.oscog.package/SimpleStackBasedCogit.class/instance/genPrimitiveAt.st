primitive generators
genPrimitiveAt
	| r |
	self MoveMw: BytesPerWord r: SPReg R: Arg0Reg.
	(r := objectRepresentation genInnerPrimitiveAt: BytesPerWord * 2) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive