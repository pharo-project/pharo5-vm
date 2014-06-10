primitive generators
genPrimitiveStringAt
	| r |
	self MoveMw: BytesPerWord r: SPReg R: Arg0Reg.
	(r := objectRepresentation genInnerPrimitiveStringAt: BytesPerWord * 2) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive