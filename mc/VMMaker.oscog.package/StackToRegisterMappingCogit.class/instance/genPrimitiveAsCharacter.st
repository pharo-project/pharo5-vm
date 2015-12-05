primitive generators
genPrimitiveAsCharacter
	| na r |
	na := coInterpreter argumentCountOf: methodObj.
	r := na <= 1
			ifTrue:
				[objectRepresentation
						genInnerPrimitiveAsCharacter: 0
						inReg: (na = 0 ifTrue: [ReceiverResultReg] ifFalse: [Arg0Reg])]
			ifFalse: [0].
	^self compileFallbackToInterpreterPrimitive: r