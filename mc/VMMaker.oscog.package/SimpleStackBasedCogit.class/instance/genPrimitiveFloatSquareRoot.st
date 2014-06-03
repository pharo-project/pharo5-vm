primitive generators
genPrimitiveFloatSquareRoot
	"Stack looks like
		receiver (also in ResultReceiverReg)
		return address"
	| jumpFailAlloc |
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	objectRepresentation genGetDoubleValueOf: ReceiverResultReg into: DPFPReg0.
	self SqrtRd: DPFPReg0.
	jumpFailAlloc := objectRepresentation
					genAllocFloatValue: DPFPReg0
					into: SendNumArgsReg
					scratchReg: ClassReg
					scratchReg: TempReg.
	self MoveR: SendNumArgsReg R: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord.
	jumpFailAlloc jmpTarget: self Label.
	^self compileFallbackToInterpreterPrimitive