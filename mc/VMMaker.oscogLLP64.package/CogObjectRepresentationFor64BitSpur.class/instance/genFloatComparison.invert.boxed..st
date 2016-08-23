primitive generators
genFloatComparison: jumpOpcodeGenerator invert: invertComparison boxed: rcvrBoxed
	<var: #jumpOpcodeGenerator declareC: 'AbstractInstruction *(*jumpOpcodeGenerator)(void *)'>
	<inline: false>
	| jumpImmediate jumpNotSmallFloat jumpNotSmallInteger jumpNotBoxedFloat jumpCond compare |
	<var: #jumpNotSmallInteger type: #'AbstractInstruction *'>
	<var: #jumpNotBoxedFloat type: #'AbstractInstruction *'>
	<var: #jumpNotSmallFloat type: #'AbstractInstruction *'>
	<var: #jumpImmediate type: #'AbstractInstruction *'>
	<var: #jumpCond type: #'AbstractInstruction *'>
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	rcvrBoxed
		ifTrue: [self genGetDoubleValueOf: ReceiverResultReg into: DPFPReg0]
		ifFalse: [self genGetSmallFloatValueOf: ReceiverResultReg scratch: TempReg into: DPFPReg0].
	jumpNotSmallFloat := self genJumpNotSmallFloat: Arg0Reg.
	self genGetSmallFloatValueOf: Arg0Reg scratch: TempReg into: DPFPReg1.
	compare := invertComparison "May need to invert for NaNs"
					ifTrue: [cogit CmpRd: DPFPReg0 Rd: DPFPReg1]
					ifFalse: [cogit CmpRd: DPFPReg1 Rd: DPFPReg0].
	jumpCond := cogit perform: jumpOpcodeGenerator with: 0. "FP jumps are a little weird"
	cogit genMoveFalseR: ReceiverResultReg.
	cogit genPrimReturn.
	jumpCond jmpTarget: (cogit genMoveTrueR: ReceiverResultReg).
	cogit genPrimReturn.
	jumpNotSmallFloat jmpTarget: cogit Label.
	jumpNotSmallInteger := self genJumpNotSmallInteger: Arg0Reg.
	self genConvertSmallIntegerToIntegerInReg: Arg0Reg.
	cogit ConvertR: Arg0Reg Rd: DPFPReg1.
	cogit Jump: compare.
	jumpNotSmallInteger jmpTarget: cogit Label.
	jumpImmediate := self genJumpImmediate: Arg0Reg.
	self genGetCompactClassIndexNonImmOf: Arg0Reg into: SendNumArgsReg.
	self genCmpClassFloatCompactIndexR: SendNumArgsReg.
	jumpNotBoxedFloat := cogit JumpNonZero: 0.
	self genGetDoubleValueOf: Arg0Reg into: DPFPReg1.
	cogit Jump: compare.
	jumpImmediate jmpTarget:
	(jumpNotBoxedFloat jmpTarget: cogit Label).
	^CompletePrimitive