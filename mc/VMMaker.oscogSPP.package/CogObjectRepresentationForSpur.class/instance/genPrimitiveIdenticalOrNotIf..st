primitive generators
genPrimitiveIdenticalOrNotIf: orNot
	| jumpCmp comp |
	<var: #jumpCmp type: #'AbstractInstruction *'>
	<var: #comp type: #'AbstractInstruction *'>
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	comp := cogit CmpR: Arg0Reg R: ReceiverResultReg.
	orNot
		ifTrue: 
			[ jumpCmp := cogit JumpZero: 0.
			self genEnsureOopInRegNotForwarded: Arg0Reg scratchReg: TempReg jumpBackTo: comp ]
		ifFalse: 
			[ jumpCmp := cogit JumpNonZero: 0 ].
	cogit genMoveTrueR: ReceiverResultReg.
	cogit genPrimReturn.
	jumpCmp jmpTarget: cogit Label.
	orNot ifFalse: 
		[ self genEnsureOopInRegNotForwarded: Arg0Reg scratchReg: TempReg jumpBackTo: comp ].
	cogit genMoveFalseR: ReceiverResultReg.
	cogit genPrimReturn.
	^UnfailingPrimitive
