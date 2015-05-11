primitive generators
genPrimitiveClass
	NewspeakVM
		ifTrue:
			[methodOrBlockNumArgs > 0 ifTrue:
				[methodOrBlockNumArgs > 1 ifTrue:
					[^self compileFallbackToInterpreterPrimitive].
			 self genLoadArgAtDepth: 0 into: ReceiverResultReg]]
		ifFalse:
			[self assert: methodOrBlockNumArgs = 0].
	(objectRepresentation
			genGetClassObjectOf: ReceiverResultReg
			into: ReceiverResultReg
			scratchReg: TempReg
			instRegIsReceiver: (NewspeakVM ifTrue: [methodOrBlockNumArgs = 0] ifFalse: [true])) = BadRegisterSet ifTrue:
		[objectRepresentation
			genGetClassObjectOf: ReceiverResultReg
			into: ClassReg
			scratchReg: TempReg
			instRegIsReceiver: (NewspeakVM ifTrue: [methodOrBlockNumArgs = 0] ifFalse: [true]).
		 self MoveR: ClassReg R: ReceiverResultReg].
	self RetN: (self primRetNOffsetFor: methodOrBlockNumArgs).
	^0