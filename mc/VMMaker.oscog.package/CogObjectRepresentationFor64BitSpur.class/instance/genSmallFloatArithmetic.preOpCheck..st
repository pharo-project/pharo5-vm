primitive generators
genSmallFloatArithmetic: arithmeticOperator preOpCheck: preOpCheckOrNil
	<var: #preOpCheckOrNil declareC: 'AbstractInstruction *(*preOpCheckOrNil)(int rcvrReg, int argReg)'>
	| jumpFailClass jumpFailAlloc jumpFailCheck jumpImmediate jumpNonInt doOp |
	<var: #jumpFailClass type: #'AbstractInstruction *'>
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	<var: #jumpNonInt type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	<var: #jumpFailCheck type: #'AbstractInstruction *'>
	<var: #doOp type: #'AbstractInstruction *'>
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	self genGetSmallFloatValueOf: ReceiverResultReg scratch: SendNumArgsReg into: DPFPReg0.
	cogit MoveR: Arg0Reg R: ClassReg.
	jumpImmediate := self genJumpImmediate: Arg0Reg.
	self genGetCompactClassIndexNonImmOf: Arg0Reg into: SendNumArgsReg.
	self genCmpClassFloatCompactIndexR: SendNumArgsReg.
	jumpFailClass := cogit JumpNonZero: 0.
	self genGetDoubleValueOf: Arg0Reg into: DPFPReg1.
	doOp := cogit Label.
	preOpCheckOrNil ifNotNil:
		[jumpFailCheck := cogit perform: preOpCheckOrNil with: DPFPReg0 with: DPFPReg1].
	cogit gen: arithmeticOperator operand: DPFPReg1 operand: DPFPReg0.
	jumpFailAlloc := self
						genAllocFloatValue: DPFPReg0
						into: SendNumArgsReg
						scratchReg: ClassReg
						scratchReg: TempReg.
	cogit MoveR: SendNumArgsReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpImmediate jmpTarget: cogit Label.
	self maybeGenConvertIfSmallFloatIn: Arg0Reg scratchReg: TempReg into: DPFPReg1 andJumpTo: doOp.
	jumpNonInt := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self genConvertSmallIntegerToIntegerInReg: ClassReg.
	cogit ConvertR: ClassReg Rd: DPFPReg1.
	cogit Jump: doOp.
	jumpFailClass jmpTarget: cogit Label.
	jumpNonInt jmpTarget: jumpFailClass getJmpTarget.
	preOpCheckOrNil ifNotNil:
		[jumpFailCheck jmpTarget: jumpFailClass getJmpTarget].
	jumpFailAlloc jmpTarget: cogit Label.
	^0