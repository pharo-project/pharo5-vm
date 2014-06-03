primitive generators
genSmallIntegerComparison: jumpOpcode orDoubleComparison: jumpFPOpcodeGenerator
	"Stack looks like
		return address"
	| jumpDouble jumpNonInt jumpFail jumpTrue jumpCond |
	<var: #jumpFPOpcodeGenerator declareC: 'AbstractInstruction *(*jumpFPOpcodeGenerator)(void *)'>
	<var: #jumpDouble type: #'AbstractInstruction *'>
	<var: #jumpNonInt type: #'AbstractInstruction *'>
	<var: #jumpCond type: #'AbstractInstruction *'>
	<var: #jumpTrue type: #'AbstractInstruction *'>
	<var: #jumpFail type: #'AbstractInstruction *'>
	self MoveR: Arg0Reg R: TempReg.
	jumpDouble := objectRepresentation genJumpNotSmallIntegerInScratchReg: TempReg.
	self CmpR: Arg0Reg R: ReceiverResultReg. "N.B. FLAGS := RRReg - Arg0Reg"
	jumpTrue := self gen: jumpOpcode.
	self annotate: (self MoveCw: objectMemory falseObject R: ReceiverResultReg)
		objRef: objectMemory falseObject.
	self RetN: 0.
	jumpTrue jmpTarget: (self annotate: (self MoveCw: objectMemory trueObject R: ReceiverResultReg)
								objRef: objectMemory trueObject).
	self RetN: 0.
	
	"Argument may be a Float : let us check or fail"
	jumpDouble jmpTarget: self Label.
	objectRepresentation smallIntegerIsOnlyImmediateType ifFalse:
		[self MoveR: ClassReg R: TempReg.
		 jumpNonInt := objectRepresentation genJumpImmediateInScratchReg: TempReg].
	objectRepresentation genGetCompactClassIndexNonImmOf: Arg0Reg into: SendNumArgsReg.
	self CmpCq: objectMemory classFloatCompactIndex R: SendNumArgsReg.
	jumpFail := self JumpNonZero: 0.

	"It was a Float, so convert the receiver to double and perform the operation"
	objectRepresentation genConvertSmallIntegerToIntegerInReg: ReceiverResultReg.
	self ConvertR: ReceiverResultReg Rd: DPFPReg0.
	objectRepresentation genGetDoubleValueOf: Arg0Reg into: DPFPReg1.
	self CmpRd: DPFPReg1 Rd: DPFPReg0.
	jumpCond := self perform: jumpFPOpcodeGenerator with: 0. "FP jumps are a little weird"
	self annotate: (self MoveCw: objectMemory falseObject R: ReceiverResultReg)
		objRef: objectMemory falseObject.
	self RetN: 0.
	jumpCond jmpTarget: (self annotate: (self MoveCw: objectMemory trueObject R: ReceiverResultReg)
							objRef: objectMemory trueObject).
	self RetN: 0.

	objectRepresentation smallIntegerIsOnlyImmediateType
		ifTrue: [jumpFail jmpTarget: self Label]
		ifFalse: [jumpNonInt jmpTarget: (jumpFail jmpTarget: self Label)].
	^0