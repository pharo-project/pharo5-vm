primitive generators
genSmallIntegerComparison: jumpOpcode
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	| jumpFail jumpTrue |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpTrue type: #'AbstractInstruction *'>
	self MoveMw: BytesPerWord r: SPReg R: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpFail := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self CmpR: ClassReg R: ReceiverResultReg. "N.B. FLAGS := RRReg - ClassReg"
	jumpTrue := self gen: jumpOpcode.
	self annotate: (self MoveCw: objectMemory falseObject R: ReceiverResultReg)
		objRef: objectMemory falseObject.
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord * 2.
	jumpTrue jmpTarget: (self annotate: (self MoveCw: objectMemory trueObject R: ReceiverResultReg)
						objRef: objectMemory trueObject).
	self RetN: BytesPerWord * 2.
	jumpFail jmpTarget: self Label.
	^0