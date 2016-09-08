primitive generators
genPrimitiveFloatSquareRoot
	<option: #DPFPReg0>
	| jumpFailAlloc |
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	cogit processorHasDoublePrecisionFloatingPointSupport ifFalse:
		[^UnimplementedPrimitive].
	self genGetDoubleValueOf: ReceiverResultReg into: DPFPReg0.
	cogit SqrtRd: DPFPReg0.
	jumpFailAlloc := self
						genAllocFloatValue: DPFPReg0
						into: SendNumArgsReg
						scratchReg: ClassReg
						scratchReg: TempReg.
	cogit MoveR: SendNumArgsReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpFailAlloc jmpTarget: cogit Label.
	^0