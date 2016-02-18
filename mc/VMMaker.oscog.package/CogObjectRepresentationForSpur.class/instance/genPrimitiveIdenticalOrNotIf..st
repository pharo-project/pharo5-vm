primitive generators
genPrimitiveIdenticalOrNotIf: orNot
	| jumpImmediate jumpCmp |
	<var: #jumpCmp type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	jumpImmediate := self genJumpImmediate: Arg0Reg.
	self genEnsureObjInRegNotForwarded: Arg0Reg scratchReg: TempReg.
	jumpImmediate jmpTarget:
		(cogit CmpR: Arg0Reg R: ReceiverResultReg).
	jumpCmp := orNot
					ifTrue: [cogit JumpZero: 0]
					ifFalse: [cogit JumpNonZero: 0].
	cogit genMoveTrueR: ReceiverResultReg.
	cogit genPrimReturn.
	jumpCmp jmpTarget: (cogit genMoveFalseR: ReceiverResultReg).
	cogit genPrimReturn.
	^UnfailingPrimitive