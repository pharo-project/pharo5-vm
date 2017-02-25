primitive generators
genFloatArithmetic: arithmeticOperator preOpCheck: preOpCheckOrNil boxed: rcvrBoxed
	<var: #preOpCheckOrNil declareC: 'AbstractInstruction *(*preOpCheckOrNil)(int rcvrReg, int argReg)'>
	<inline: false>
	| jumpFailAlloc jumpFailCheck jumpImmediate jumpNotSmallFloat jumpNotSmallInteger jumpNotBoxedFloat doOp |
	<var: #jumpNotSmallInteger type: #'AbstractInstruction *'>
	<var: #jumpNotBoxedFloat type: #'AbstractInstruction *'>
	<var: #jumpNotSmallFloat type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	<var: #jumpFailCheck type: #'AbstractInstruction *'>
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	<var: #doOp type: #'AbstractInstruction *'>
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	rcvrBoxed
		ifTrue: [self genGetDoubleValueOf: ReceiverResultReg into: DPFPReg0]
		ifFalse: [self genGetSmallFloatValueOf: ReceiverResultReg scratch: TempReg into: DPFPReg0].
	jumpNotSmallFloat := self genJumpNotSmallFloat: Arg0Reg.
	self genGetSmallFloatValueOf: Arg0Reg scratch: TempReg into: DPFPReg1.
	doOp := cogit Label.
	preOpCheckOrNil ifNotNil:
		[jumpFailCheck := cogit perform: preOpCheckOrNil with: DPFPReg0 with: DPFPReg1].
	cogit gen: arithmeticOperator operand: DPFPReg1 operand: DPFPReg0.
	jumpFailAlloc := self genAllocFloatValue: DPFPReg0 into: SendNumArgsReg scratchReg: ClassReg scratchReg: TempReg.
	cogit MoveR: SendNumArgsReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpNotSmallFloat jmpTarget: cogit Label.
	jumpNotSmallInteger := self genJumpNotSmallInteger: Arg0Reg.
	cogit MoveR: Arg0Reg R: Arg1Reg.
	self genConvertSmallIntegerToIntegerInReg: Arg1Reg.
	cogit ConvertR: Arg1Reg Rd: DPFPReg1.
	cogit Jump: doOp.
	jumpNotSmallInteger jmpTarget: cogit Label.
	jumpImmediate := self genJumpImmediate: Arg0Reg.
	self genGetCompactClassIndexNonImmOf: Arg0Reg into: SendNumArgsReg.
	self genCmpClassFloatCompactIndexR: SendNumArgsReg.
	jumpNotBoxedFloat := cogit JumpNonZero: 0.
	self genGetDoubleValueOf: Arg0Reg into: DPFPReg1.
	cogit Jump: doOp.
	jumpImmediate jmpTarget:
	(jumpNotBoxedFloat jmpTarget:
	(jumpNotSmallInteger jmpTarget:
	(jumpFailAlloc jmpTarget: cogit Label))).
	preOpCheckOrNil ifNotNil:
		[jumpFailCheck jmpTarget: jumpFailAlloc getJmpTarget].
	^0