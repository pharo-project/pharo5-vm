primitive generators
genDoubleComparison: jumpOpcodeGenerator invert: invertComparison
	"Receiver and arg in registers.
	 Stack looks like
		return address"
	<var: #jumpOpcodeGenerator declareC: 'AbstractInstruction *(*jumpOpcodeGenerator)(void *)'>
	| jumpFail jumpSmallInt jumpCond compare |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpSmallInt type: #'AbstractInstruction *'>
	<var: #jumpCond type: #'AbstractInstruction *'>
	<var: #compare type: #'AbstractInstruction *'>
	self MoveR: Arg0Reg R: TempReg.
	objectRepresentation genGetDoubleValueOf: ReceiverResultReg into: DPFPReg0.
	jumpSmallInt := objectRepresentation genJumpSmallIntegerInScratchReg: TempReg.
	objectRepresentation genGetCompactClassIndexNonIntOf: Arg0Reg into: SendNumArgsReg.
	self CmpCq: objectMemory classFloatCompactIndex R: SendNumArgsReg.
	jumpFail := self JumpNonZero: 0.
	objectRepresentation genGetDoubleValueOf: Arg0Reg into: DPFPReg1.
	invertComparison "May need to invert for NaNs"
		ifTrue: [compare := self CmpRd: DPFPReg0 Rd: DPFPReg1]
		ifFalse: [compare := self CmpRd: DPFPReg1 Rd: DPFPReg0].
	jumpCond := self perform: jumpOpcodeGenerator with: 0. "FP jumps are a little weird"
	self annotate: (self MoveCw: objectMemory falseObject R: ReceiverResultReg)
		objRef: objectMemory falseObject.
	self RetN: 0.
	jumpCond jmpTarget: (self annotate: (self MoveCw: objectMemory trueObject R: ReceiverResultReg)
								objRef: objectMemory trueObject).
	self RetN: 0.
	jumpSmallInt jmpTarget: self Label.
	objectRepresentation genConvertSmallIntegerToIntegerInScratchReg: Arg0Reg.
	self ConvertR: Arg0Reg Rd: DPFPReg1.
	self Jump: compare.
	jumpFail jmpTarget: self Label.
	^0