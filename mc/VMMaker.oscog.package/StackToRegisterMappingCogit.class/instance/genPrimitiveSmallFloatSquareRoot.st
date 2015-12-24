primitive generators
genPrimitiveSmallFloatSquareRoot
	<option: #Spur64BitMemoryManager>
	| jumpFailAlloc |
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	objectRepresentation genGetSmallFloatValueOf: ReceiverResultReg into: DPFPReg0.
	self SqrtRd: DPFPReg0.
	jumpFailAlloc := objectRepresentation
						genAllocFloatValue: DPFPReg0
						into: SendNumArgsReg
						scratchReg: ClassReg
						scratchReg: TempReg.
	self MoveR: SendNumArgsReg R: ReceiverResultReg.
	self RetN: 0.
	jumpFailAlloc jmpTarget: self Label.
	^self compileFallbackToInterpreterPrimitive: 0