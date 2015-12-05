primitive generators
genPrimitiveAsFloat
	"Stack looks like
		receiver (also in ResultReceiverReg)
		return address"
	| jumpFailAlloc |
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	self MoveR: ReceiverResultReg R: ClassReg.
	objectRepresentation genConvertSmallIntegerToIntegerInReg: ClassReg.
	self ConvertR: ClassReg Rd: DPFPReg0.
	jumpFailAlloc := objectRepresentation
					genAllocFloatValue: DPFPReg0
					into: SendNumArgsReg
					scratchReg: ClassReg
					scratchReg: TempReg.
	self MoveR: SendNumArgsReg R: ReceiverResultReg.
	self RetN: (self primRetNOffsetFor: 0).
	jumpFailAlloc jmpTarget: self Label.
	^self compileFallbackToInterpreterPrimitive: 0