primitive generators
genInnerPrimitiveIdentical: retNoffset orNotIf: orNot
	| jumpImmediate jumpCmp |
	<var: #jumpCmp type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	cogit MoveR: Arg0Reg R: TempReg.
	jumpImmediate := self genJumpImmediateInScratchReg: TempReg.
	self genEnsureObjInRegNotForwarded: Arg0Reg scratchReg: TempReg.
	jumpImmediate jmpTarget:
		(cogit CmpR: Arg0Reg R: ReceiverResultReg).
	jumpCmp := orNot
					ifTrue: [cogit JumpZero: 0]
					ifFalse: [cogit JumpNonZero: 0].
	cogit annotate: (cogit MoveCw: objectMemory trueObject R: ReceiverResultReg)
		objRef: objectMemory trueObject.
	cogit RetN: retNoffset.
	jumpCmp jmpTarget: (cogit annotate: (cogit MoveCw: objectMemory falseObject R: ReceiverResultReg)
								objRef: objectMemory falseObject).
	cogit RetN: retNoffset.
	^0