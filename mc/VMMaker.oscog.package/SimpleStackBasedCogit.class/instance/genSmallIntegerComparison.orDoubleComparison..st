primitive generators
genSmallIntegerComparison: jumpOpcode orDoubleComparison: jumpFPOpcodeGenerator
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	| jumpDouble jumpNonInt jumpFail jumpTrue jumpCond |
	<var: #jumpFPOpcodeGenerator declareC: 'AbstractInstruction *(*jumpFPOpcodeGenerator)(void *)'>
	<var: #jumpDouble type: #'AbstractInstruction *'>
	<var: #jumpNonInt type: #'AbstractInstruction *'>
	<var: #jumpCond type: #'AbstractInstruction *'>
	<var: #jumpTrue type: #'AbstractInstruction *'>
	<var: #jumpFail type: #'AbstractInstruction *'>
	backEnd hasDoublePrecisionFloatingPointSupport ifFalse:
		[^self genSmallIntegerComparison: jumpOpcode].
	self genLoadArgAtDepth: 0 into: TempReg.
	self MoveR: TempReg R: ClassReg.
	jumpDouble := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self CmpR: ClassReg R: ReceiverResultReg. "N.B. FLAGS := RRReg - ClassReg"
	jumpTrue := self gen: jumpOpcode.
	self genMoveFalseR: ReceiverResultReg.
	self RetN: (self primRetNOffsetFor: 1).
	jumpTrue jmpTarget: (self genMoveTrueR: ReceiverResultReg).
	self RetN: (self primRetNOffsetFor: 1).
	
	"Argument may be a Float : let us check or fail"
	jumpDouble jmpTarget: self Label.
	objectRepresentation smallIntegerIsOnlyImmediateType ifFalse:
		[self MoveR: ClassReg R: TempReg.
		 jumpNonInt := objectRepresentation genJumpImmediateInScratchReg: TempReg].
	objectRepresentation genGetCompactClassIndexNonImmOf: ClassReg into: SendNumArgsReg.
	objectRepresentation genCmpClassFloatCompactIndexR: SendNumArgsReg.
	jumpFail := self JumpNonZero: 0.

	"It was a Float, so convert the receiver to double and perform the operation"
	self MoveR: ReceiverResultReg R: TempReg.
	objectRepresentation genConvertSmallIntegerToIntegerInReg: TempReg.
	self ConvertR: TempReg Rd: DPFPReg0.
	objectRepresentation genGetDoubleValueOf: ClassReg into: DPFPReg1.
	self CmpRd: DPFPReg1 Rd: DPFPReg0.
	jumpCond := self perform: jumpFPOpcodeGenerator with: 0. "FP jumps are a little weird"
	self genMoveFalseR: ReceiverResultReg.
	self RetN: (self primRetNOffsetFor: 1).
	jumpCond jmpTarget: (self genMoveTrueR: ReceiverResultReg).
	self RetN: (self primRetNOffsetFor: 1).

	objectRepresentation smallIntegerIsOnlyImmediateType
		ifTrue: [jumpFail jmpTarget: self Label]
		ifFalse: [jumpNonInt jmpTarget: (jumpFail jmpTarget: self Label)].
	^0