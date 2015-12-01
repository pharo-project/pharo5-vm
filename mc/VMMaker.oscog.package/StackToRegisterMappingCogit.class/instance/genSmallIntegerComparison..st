primitive generators
genSmallIntegerComparison: jumpOpcode
	| jumpFail jumpTrue |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpTrue type: #'AbstractInstruction *'>
	jumpFail := objectRepresentation genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self CmpR: Arg0Reg R: ReceiverResultReg. "N.B. FLAGS := RRReg - Arg0Reg"
	jumpTrue := self genConditionalBranch: jumpOpcode operand: 0.
	self genMoveFalseR: ReceiverResultReg.
	self RetN: 0.
	jumpTrue jmpTarget: (self genMoveTrueR: ReceiverResultReg).
	self RetN: 0.
	jumpFail jmpTarget: self Label.
	^0