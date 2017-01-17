primitive generators
genPrimitiveClass
	| reg |
	reg := ReceiverResultReg.
	cogit methodNumArgs > 0 ifTrue:
		[cogit methodNumArgs > 1 ifTrue:
			[^UnimplementedPrimitive].
		 cogit genLoadArgAtDepth: 0 into: (reg := Arg0Reg)].
	(self
			genGetClassObjectOf: reg
			into: ReceiverResultReg
			scratchReg: TempReg
			instRegIsReceiver: reg = ReceiverResultReg) = BadRegisterSet ifTrue:
		[self
			genGetClassObjectOf: reg
			into: ClassReg
			scratchReg: TempReg
			instRegIsReceiver: reg = ReceiverResultReg.
		 cogit MoveR: ClassReg R: ReceiverResultReg].
	cogit genPrimReturn.
	^UnfailingPrimitive