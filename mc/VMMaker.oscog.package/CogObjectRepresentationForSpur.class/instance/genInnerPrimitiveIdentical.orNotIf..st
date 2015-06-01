primitive generators
genInnerPrimitiveIdentical: retNoffset orNotIf: orNot
	| jumpImmediate jumpCmp |
	<var: #jumpCmp type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	jumpImmediate := self genJumpImmediate: Arg0Reg.
	self genEnsureObjInRegNotForwarded: Arg0Reg scratchReg: TempReg.
	jumpImmediate jmpTarget:
		(cogit CmpR: Arg0Reg R: ReceiverResultReg).
	jumpCmp := orNot
					ifTrue: [cogit JumpZero: 0]
					ifFalse: [cogit JumpNonZero: 0].
	cogit genMoveTrueR: ReceiverResultReg.
	cogit RetN: retNoffset.
	jumpCmp jmpTarget: (cogit genMoveFalseR: ReceiverResultReg).
	cogit RetN: retNoffset.
	^0