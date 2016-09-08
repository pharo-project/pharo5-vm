primitive generators
genPrimitiveAsFloat
	<option: #DPFPReg0>
	| jumpFailAlloc |
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	cogit processorHasDoublePrecisionFloatingPointSupport ifFalse:
		[^UnimplementedPrimitive].
	cogit MoveR: ReceiverResultReg R: TempReg.
	self genConvertSmallIntegerToIntegerInReg: TempReg.
	cogit ConvertR: TempReg Rd: DPFPReg0.
	jumpFailAlloc := self
						genAllocFloatValue: DPFPReg0
						into: SendNumArgsReg
						scratchReg: ClassReg
						scratchReg: TempReg.
	cogit MoveR: SendNumArgsReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpFailAlloc jmpTarget: cogit Label.
	^0