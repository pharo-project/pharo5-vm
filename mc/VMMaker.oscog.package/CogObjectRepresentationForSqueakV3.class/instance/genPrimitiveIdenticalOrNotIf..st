primitive generators
genPrimitiveIdenticalOrNotIf: orNot
	| jumpCmp |
	<var: #jumpCmp type: #'AbstractInstruction *'>
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	cogit CmpR: Arg0Reg R: ReceiverResultReg.
	jumpCmp := orNot
					ifTrue: [cogit JumpZero: 0]
					ifFalse: [cogit JumpNonZero: 0].
	cogit genMoveTrueR: ReceiverResultReg.
	cogit genPrimReturn.
	jumpCmp jmpTarget: (cogit genMoveFalseR: ReceiverResultReg).
	cogit genPrimReturn.
	^UnfailingPrimitive