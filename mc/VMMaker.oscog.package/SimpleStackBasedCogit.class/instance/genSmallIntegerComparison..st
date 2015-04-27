primitive generators
genSmallIntegerComparison: jumpOpcode
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	| jumpFail jumpTrue |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpTrue type: #'AbstractInstruction *'>
	self MoveMw: objectMemory wordSize r: SPReg R: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpFail := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self CmpR: ClassReg R: ReceiverResultReg. "N.B. FLAGS := RRReg - ClassReg"
	jumpTrue := self gen: jumpOpcode.
	self genMoveFalseR: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	self RetN: objectMemory wordSize * 2.
	jumpTrue jmpTarget: (self genMoveTrueR: ReceiverResultReg).
	self RetN: objectMemory wordSize * 2.
	jumpFail jmpTarget: self Label.
	^0