primitive generators
genSmallIntegerComparison: jumpOpcode
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	| jumpFail jumpTrue |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpTrue type: #'AbstractInstruction *'>
	self genLoadArgAtDepth: 0 into: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpFail := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self CmpR: ClassReg R: ReceiverResultReg. "N.B. FLAGS := RRReg - ClassReg"
	jumpTrue := self gen: jumpOpcode.
	self genMoveFalseR: ReceiverResultReg.
	self RetN: (self primRetNOffsetFor: 1).
	jumpTrue jmpTarget: (self genMoveTrueR: ReceiverResultReg).
	self RetN: (self primRetNOffsetFor: 1).
	jumpFail jmpTarget: self Label.
	^0