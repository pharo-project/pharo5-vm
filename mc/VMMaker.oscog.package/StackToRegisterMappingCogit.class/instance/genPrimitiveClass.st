primitive generators
genPrimitiveClass
	| reg |
	reg := ReceiverResultReg.
	NewspeakVM
		ifTrue:
			[methodOrBlockNumArgs > 0 ifTrue:
				[methodOrBlockNumArgs > 1 ifTrue:
					[^self compileFallbackToInterpreterPrimitive].
				 reg := Arg0Reg]]
		ifFalse:
			[self assert: methodOrBlockNumArgs = 0].
	(objectRepresentation
			genGetClassObjectOf: reg
			into: ReceiverResultReg
			scratchReg: TempReg
			instRegIsReceiver: (NewspeakVM ifTrue: [methodOrBlockNumArgs = 0] ifFalse: [true])) = BadRegisterSet ifTrue:
		[objectRepresentation
			genGetClassObjectOf: reg
			into: ClassReg
			scratchReg: TempReg
			instRegIsReceiver: (NewspeakVM ifTrue: [methodOrBlockNumArgs = 0] ifFalse: [true]).
		 self MoveR: ClassReg R: ReceiverResultReg].
	self RetN: 0.
	^0