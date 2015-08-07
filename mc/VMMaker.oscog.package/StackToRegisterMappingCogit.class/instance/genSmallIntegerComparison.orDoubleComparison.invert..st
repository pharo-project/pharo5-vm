primitive generators
genSmallIntegerComparison: jumpOpcode orDoubleComparison: jumpFPOpcodeGenerator invert: invertComparison
	"Stack looks like
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
	jumpDouble := objectRepresentation genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self CmpR: Arg0Reg R: ReceiverResultReg. "N.B. FLAGS := RRReg - Arg0Reg"
	jumpTrue := self gen: jumpOpcode.
	self genMoveFalseR: ReceiverResultReg.
	self RetN: 0.
	jumpTrue jmpTarget: (self genMoveTrueR: ReceiverResultReg).
	self RetN: 0.
	
	"Argument may be a Float : let us check or fail"
	jumpDouble jmpTarget: self Label.
	objectRepresentation smallIntegerIsOnlyImmediateType ifFalse:
		[jumpNonInt := objectRepresentation genJumpImmediate: Arg0Reg].
	objectRepresentation genGetCompactClassIndexNonImmOf: Arg0Reg into: SendNumArgsReg.
	objectRepresentation genCmpClassFloatCompactIndexR: SendNumArgsReg.
	jumpFail := self JumpNonZero: 0.

	"It was a Float, so convert the receiver to double and perform the operation"
	objectRepresentation genConvertSmallIntegerToIntegerInReg: ReceiverResultReg.
	self ConvertR: ReceiverResultReg Rd: DPFPReg0.
	objectRepresentation genGetDoubleValueOf: Arg0Reg into: DPFPReg1.
	invertComparison "May need to invert for NaNs"
		ifTrue: [self CmpRd: DPFPReg0 Rd: DPFPReg1]
		ifFalse: [self CmpRd: DPFPReg1 Rd: DPFPReg0].
	jumpCond := self perform: jumpFPOpcodeGenerator with: 0. "FP jumps are a little weird"
	self genMoveFalseR: ReceiverResultReg.
	self RetN: 0.
	jumpCond jmpTarget: (self genMoveTrueR: ReceiverResultReg).
	self RetN: 0.

	objectRepresentation smallIntegerIsOnlyImmediateType
		ifTrue: [jumpFail jmpTarget: self Label]
		ifFalse: [jumpNonInt jmpTarget: (jumpFail jmpTarget: self Label)].
	^0