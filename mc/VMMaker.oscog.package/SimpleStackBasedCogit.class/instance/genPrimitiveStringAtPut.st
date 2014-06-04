primitive generators
genPrimitiveStringAtPut
	| r |
	self MoveMw: BytesPerWord * 2 r: SPReg R: Arg0Reg.
	self MoveMw: BytesPerWord r: SPReg R: Arg1Reg.
	((r := objectRepresentation genInnerPrimitiveStringAtPut: BytesPerWord * 3) < 0
	 and: [r ~= UnimplementedPrimitive]) ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive