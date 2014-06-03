primitive generators
genInnerPrimitiveIdentical: retNoffset orNotIf: orNot
	| jumpCmp |
	<var: #jumpCmp type: #'AbstractInstruction *'>
	cogit CmpR: Arg0Reg R: ReceiverResultReg.
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