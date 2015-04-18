primitive generators
genSmallIntegerComparison: jumpOpcode
	| jumpFail jumpTrue |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpTrue type: #'AbstractInstruction *'>
	self MoveR: Arg0Reg R: TempReg.
	jumpFail := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self CmpR: Arg0Reg R: ReceiverResultReg. "N.B. FLAGS := RRReg - Arg0Reg"
	jumpTrue := self gen: jumpOpcode.
	self genMoveFalseR: ReceiverResultReg.
	self RetN: 0.
	jumpTrue jmpTarget: (self genMoveTrueR: ReceiverResultReg).
	self RetN: 0.
	jumpFail jmpTarget: self Label.
	^0