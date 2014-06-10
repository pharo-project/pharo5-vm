primitive generators
genPrimitiveAsCharacter
	| na r |
	na := coInterpreter argumentCountOf: methodObj.
	na <= 1 ifTrue:
		[(r := objectRepresentation
				genInnerPrimitiveAsCharacter: 0
				inReg: (na = 0 ifTrue: [ReceiverResultReg] ifFalse: [Arg0Reg])) < 0 ifTrue:
			[^r]].
	^self compileFallbackToInterpreterPrimitive