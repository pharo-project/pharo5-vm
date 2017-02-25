primitive generators
genSmallIntegerComparison: jumpOpcode
	| jumpFail jumpTrue |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpTrue type: #'AbstractInstruction *'>
	cogit mclassIsSmallInteger ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	jumpFail := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	cogit CmpR: Arg0Reg R: ReceiverResultReg. "N.B. FLAGS := RRReg - Arg0Reg"
	jumpTrue := cogit genConditionalBranch: jumpOpcode operand: 0.
	cogit genMoveFalseR: ReceiverResultReg.
	cogit genPrimReturn.
	jumpTrue jmpTarget: (cogit genMoveTrueR: ReceiverResultReg).
	cogit genPrimReturn.
	jumpFail jmpTarget: cogit Label.
	^CompletePrimitive