primitive generators
genPrimitiveAsCharacter
	| na r |
	na := coInterpreter argumentCountOf: methodObj.
	na <= 1 ifTrue:
		[na = 1 ifTrue:
			[self MoveMw: BytesPerWord r: SPReg R: Arg0Reg].
		 (r := objectRepresentation
				genInnerPrimitiveAsCharacter: 0
				inReg: (na = 0 ifTrue: [ReceiverResultReg] ifFalse: [Arg0Reg])) < 0 ifTrue:
			[^r]].
	^self compileFallbackToInterpreterPrimitive