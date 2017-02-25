primitive generators
genDoubleComparison: jumpOpcodeGenerator invert: invertComparison
	<option: #DPFPReg0>
	<var: #jumpOpcodeGenerator declareC: 'AbstractInstruction * NoDbgRegParms (*jumpOpcodeGenerator)(void *)'>
	| jumpFail jumpImmediate jumpNonInt jumpCond compare |
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	<var: #jumpNonInt type: #'AbstractInstruction *'>
	<var: #jumpCond type: #'AbstractInstruction *'>
	<var: #compare type: #'AbstractInstruction *'>
	<var: #jumpFail type: #'AbstractInstruction *'>
	cogit processorHasDoublePrecisionFloatingPointSupport ifFalse:
		[^UnimplementedPrimitive].
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	self genGetDoubleValueOf: ReceiverResultReg into: DPFPReg0.
	jumpImmediate := self genJumpImmediate: Arg0Reg.
	self genGetCompactClassIndexNonImmOf: Arg0Reg into: SendNumArgsReg.
	self genCmpClassFloatCompactIndexR: SendNumArgsReg.
	jumpFail := cogit JumpNonZero: 0.
	self genGetDoubleValueOf: Arg0Reg into: DPFPReg1.
	invertComparison "May need to invert for NaNs"
		ifTrue: [compare := cogit CmpRd: DPFPReg0 Rd: DPFPReg1]
		ifFalse: [compare := cogit CmpRd: DPFPReg1 Rd: DPFPReg0].
	jumpCond := cogit perform: jumpOpcodeGenerator with: 0. "FP jumps are a little weird"
	cogit genMoveFalseR: ReceiverResultReg.
	cogit genPrimReturn.
	jumpCond jmpTarget: (cogit genMoveTrueR: ReceiverResultReg).
	cogit genPrimReturn.
	jumpImmediate jmpTarget: cogit Label.
	self maybeGenConvertIfSmallFloatIn: Arg0Reg scratchReg: TempReg into: DPFPReg1 andJumpTo: compare.
	self smallIntegerIsOnlyImmediateType ifFalse:
		[jumpNonInt := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg].
	self genConvertSmallIntegerToIntegerInReg: Arg0Reg.
	cogit ConvertR: Arg0Reg Rd: DPFPReg1.
	cogit Jump: compare.
	jumpFail jmpTarget: cogit Label.
	self smallIntegerIsOnlyImmediateType ifFalse:
		[jumpNonInt jmpTarget: jumpFail getJmpTarget].
	^CompletePrimitive