primitive generators
genPrimitiveSubtract
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	| jumpNotSI jumpOvfl |
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpOvfl type: #'AbstractInstruction *'>
	self MoveMw: BytesPerWord r: SPReg R: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpNotSI := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self MoveR: ReceiverResultReg R: TempReg.
	self SubR: ClassReg R: TempReg.
	jumpOvfl := self JumpOverflow: 0.
	objectRepresentation genAddSmallIntegerTagsTo: TempReg.
	self MoveR: TempReg R: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord * 2.
	jumpOvfl jmpTarget: (jumpNotSI jmpTarget: self Label).
	^0