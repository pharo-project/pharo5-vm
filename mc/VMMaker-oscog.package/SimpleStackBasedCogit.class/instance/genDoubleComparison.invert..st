primitive generators
genDoubleComparison: jumpOpcodeGenerator invert: invertComparison
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	<var: #jumpOpcodeGenerator declareC: 'AbstractInstruction *(*jumpOpcodeGenerator)(void *)'>
	| jumpFail jumpSmallInt jumpCond compare |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpSmallInt type: #'AbstractInstruction *'>
	<var: #jumpCond type: #'AbstractInstruction *'>
	<var: #compare type: #'AbstractInstruction *'>
	self MoveMw: BytesPerWord r: SPReg R: TempReg.
	objectRepresentation genGetDoubleValueOf: ReceiverResultReg into: DPFPReg0.
	self MoveR: TempReg R: ClassReg.
	jumpSmallInt := objectRepresentation genJumpSmallIntegerInScratchReg: TempReg.
	objectRepresentation genGetCompactClassIndexNonIntOf: ClassReg into: SendNumArgsReg.
	self CmpCq: objectMemory classFloatCompactIndex R: SendNumArgsReg.
	jumpFail := self JumpNonZero: 0.
	objectRepresentation genGetDoubleValueOf: ClassReg into: DPFPReg1.
	invertComparison "May need to invert for NaNs"
		ifTrue: [compare := self CmpRd: DPFPReg0 Rd: DPFPReg1]
		ifFalse: [compare := self CmpRd: DPFPReg1 Rd: DPFPReg0].
	jumpCond := self perform: jumpOpcodeGenerator with: 0. "FP jumps are a little weird"
	self annotate: (self MoveCw: objectMemory falseObject R: ReceiverResultReg)
		objRef: objectMemory falseObject.
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord * 2.
	jumpCond jmpTarget: (self annotate: (self MoveCw: objectMemory trueObject R: ReceiverResultReg)
							objRef: objectMemory trueObject).
	self RetN: BytesPerWord * 2.
	jumpSmallInt jmpTarget: self Label.
	objectRepresentation genConvertSmallIntegerToIntegerInScratchReg: ClassReg.
	self ConvertR: ClassReg Rd: DPFPReg1.
	self Jump: compare.
	jumpFail jmpTarget: self Label.
	^0