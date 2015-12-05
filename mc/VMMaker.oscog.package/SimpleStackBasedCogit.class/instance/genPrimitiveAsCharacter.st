primitive generators
genPrimitiveAsCharacter
	| na r |
	na := coInterpreter argumentCountOf: methodObj.
	na <= 1
		ifTrue:
			[na = 1 ifTrue:
				[self genLoadArgAtDepth: 0 into: Arg0Reg].
			 r := objectRepresentation
					genInnerPrimitiveAsCharacter: (self primRetNOffsetFor: na)
					inReg: (na = 0 ifTrue: [ReceiverResultReg] ifFalse: [Arg0Reg])]
		ifFalse: [r := 0].
	^self compileFallbackToInterpreterPrimitive: r