primitive generators
genPrimitiveSmallFloatSquareRoot
	<option: #Spur64BitMemoryManager>
	| jumpFailAlloc jumpNegative |
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	<var: #jumpNegative type: #'AbstractInstruction *'>
	self genGetSmallFloatValueOf: ReceiverResultReg scratch: SendNumArgsReg into: DPFPReg0.
	cogit
		XorRd: DPFPReg1 Rd: DPFPReg1; "+0.0 is all zeros"
		CmpRd: DPFPReg0 Rd: DPFPReg1.
	jumpNegative := cogit JumpFPGreater: 0.
	cogit SqrtRd: DPFPReg0.
	jumpFailAlloc := self
						genAllocFloatValue: DPFPReg0
						into: SendNumArgsReg
						scratchReg: ClassReg
						scratchReg: TempReg.
	cogit MoveR: SendNumArgsReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpNegative jmpTarget: (jumpFailAlloc jmpTarget: cogit Label).
	^0