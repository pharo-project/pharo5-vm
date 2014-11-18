primitive generators
genPrimitiveAt
	| r |
	self MoveMw: objectMemory wordSize r: SPReg R: Arg0Reg.
	(r := objectRepresentation genInnerPrimitiveAt: objectMemory wordSize * 2) < 0 ifTrue:
		[^r].
	^self compileFallbackToInterpreterPrimitive