primitive generators
genPrimitiveSmallFloatSquareRoot
	<option: #Spur64BitMemoryManager>
	| jumpFailAlloc |
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	self genGetSmallFloatValueOf: ReceiverResultReg scratch: SendNumArgsReg into: DPFPReg0.
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