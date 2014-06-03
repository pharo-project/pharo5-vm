primitive generators
genSmallIntegerComparison: jumpOpcode
	| jumpFail jumpTrue |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpTrue type: #'AbstractInstruction *'>
	self MoveR: Arg0Reg R: TempReg.
	jumpFail := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self CmpR: Arg0Reg R: ReceiverResultReg. "N.B. FLAGS := RRReg - Arg0Reg"
	jumpTrue := self gen: jumpOpcode.
	self annotate: (self MoveCw: objectMemory falseObject R: ReceiverResultReg)
		objRef: objectMemory falseObject.
	self RetN: 0.
	jumpTrue jmpTarget: (self annotate: (self MoveCw: objectMemory trueObject R: ReceiverResultReg)
								objRef: objectMemory trueObject).
	self RetN: 0.
	jumpFail jmpTarget: self Label.
	^0