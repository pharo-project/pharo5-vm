primitive generators
genDoubleComparison: jumpOpcodeGenerator invert: invertComparison
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	<var: #jumpOpcodeGenerator declareC: 'AbstractInstruction *(*jumpOpcodeGenerator)(void *)'>
	| jumpFail jumpImmediate jumpNonInt jumpCond compare |
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	<var: #jumpNonInt type: #'AbstractInstruction *'>
	<var: #jumpCond type: #'AbstractInstruction *'>
	<var: #compare type: #'AbstractInstruction *'>
	<var: #jumpFail type: #'AbstractInstruction *'>

	self genLoadArgAtDepth: 0 into: TempReg.
	objectRepresentation genGetDoubleValueOf: ReceiverResultReg into: DPFPReg0.
	self MoveR: TempReg R: ClassReg.
	jumpImmediate := objectRepresentation genJumpImmediateInScratchReg: TempReg.
	objectRepresentation genGetCompactClassIndexNonImmOf: ClassReg into: SendNumArgsReg.
	objectRepresentation genCmpClassFloatCompactIndexR: SendNumArgsReg.
	jumpFail := self JumpNonZero: 0.
	objectRepresentation genGetDoubleValueOf: ClassReg into: DPFPReg1.
	invertComparison "May need to invert for NaNs"
		ifTrue: [compare := self CmpRd: DPFPReg0 Rd: DPFPReg1]
		ifFalse: [compare := self CmpRd: DPFPReg1 Rd: DPFPReg0].
	jumpCond := self perform: jumpOpcodeGenerator with: 0. "FP jumps are a little weird"
	self genMoveFalseR: ReceiverResultReg.
	self RetN: (self primRetNOffsetFor: 1).
	jumpCond jmpTarget: (self genMoveTrueR: ReceiverResultReg).
	self RetN: (self primRetNOffsetFor: 1).
	jumpImmediate jmpTarget: self Label.
	objectRepresentation smallIntegerIsOnlyImmediateType ifFalse:
		[jumpNonInt := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg].
	objectRepresentation genConvertSmallIntegerToIntegerInReg: ClassReg.
	self ConvertR: ClassReg Rd: DPFPReg1.
	self Jump: compare.
	jumpFail jmpTarget: self Label.
	objectRepresentation smallIntegerIsOnlyImmediateType ifFalse:
		[jumpNonInt jmpTarget: jumpFail getJmpTarget].
	^0