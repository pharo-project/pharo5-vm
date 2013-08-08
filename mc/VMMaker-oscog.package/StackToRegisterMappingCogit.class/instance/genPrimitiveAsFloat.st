primitive generators
genPrimitiveAsFloat
	| jumpFailAlloc |
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	self MoveR: ReceiverResultReg R: TempReg.
	objectRepresentation genConvertSmallIntegerToIntegerInScratchReg: TempReg.
	self ConvertR: TempReg Rd: DPFPReg0.
	jumpFailAlloc := objectRepresentation
						genAllocFloatValue: DPFPReg0
						into: SendNumArgsReg
						scratchReg: ClassReg
						scratchReg: TempReg.
	self MoveR: SendNumArgsReg R: ReceiverResultReg.
	self RetN: 0.
	jumpFailAlloc jmpTarget: self Label.
	self compileInterpreterPrimitive: (coInterpreter
										functionPointerForCompiledMethod: methodObj
										primitiveIndex: primitiveIndex).
	^0