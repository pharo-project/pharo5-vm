primitive generators
genPrimitiveAtPut
	| r |
	self MoveMw: objectMemory wordSize * 2 r: SPReg R: Arg0Reg.
	self MoveMw: objectMemory wordSize r: SPReg R: Arg1Reg.
	((r := objectRepresentation genInnerPrimitiveAtPut: objectMemory wordSize * 3) < 0
	 and: [r ~= UnimplementedPrimitive]) ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive