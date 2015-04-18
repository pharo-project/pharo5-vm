primitive generators
genInnerPrimitiveIdentical: retNoffset orNotIf: orNot
	| jumpCmp |
	<var: #jumpCmp type: #'AbstractInstruction *'>
	cogit CmpR: Arg0Reg R: ReceiverResultReg.
	jumpCmp := orNot
					ifTrue: [cogit JumpZero: 0]
					ifFalse: [cogit JumpNonZero: 0].
	cogit genMoveTrueR: ReceiverResultReg.
	cogit RetN: retNoffset.
	jumpCmp jmpTarget: (cogit genMoveFalseR: ReceiverResultReg).
	cogit RetN: retNoffset.
	^0