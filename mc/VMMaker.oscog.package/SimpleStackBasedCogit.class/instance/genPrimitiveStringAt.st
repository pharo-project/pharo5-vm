primitive generators
genPrimitiveStringAt
	| r |
	self MoveMw: objectMemory wordSize r: SPReg R: Arg0Reg.
	(r := objectRepresentation genInnerPrimitiveStringAt: objectMemory wordSize * 2) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive