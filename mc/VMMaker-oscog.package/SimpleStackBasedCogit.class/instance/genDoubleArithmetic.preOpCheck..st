primitive generators
genDoubleArithmetic: arithmeticOperator preOpCheck: preOpCheckOrNil
	"Stack looks like
		receiver (also in ResultReceiverReg)
		arg
		return address"
	<var: #preOpCheckOrNil declareC: 'AbstractInstruction *(*preOpCheckOrNil)(int rcvrReg, int argReg)'>
	| jumpFailClass jumpFailAlloc jumpFailCheck jumpSmallInt doOp fail |
	<var: #jumpFailClass type: #'AbstractInstruction *'>
	<var: #jumpFailAlloc type: #'AbstractInstruction *'>
	<var: #jumpSmallInt type: #'AbstractInstruction *'>
	<var: #jumpFailCheck type: #'AbstractInstruction *'>
	<var: #doOp type: #'AbstractInstruction *'>
	<var: #fail type: #'AbstractInstruction *'>
	self MoveMw: BytesPerWord r: SPReg R: TempReg.
	objectRepresentation genGetDoubleValueOf: ReceiverResultReg into: DPFPReg0.
	self MoveR: TempReg R: ClassReg.
	jumpSmallInt := objectRepresentation genJumpSmallIntegerInScratchReg: TempReg.
	objectRepresentation genGetCompactClassIndexNonIntOf: ClassReg into: SendNumArgsReg.
	self CmpCq: objectMemory classFloatCompactIndex R: SendNumArgsReg.
	jumpFailClass := self JumpNonZero: 0.
	objectRepresentation genGetDoubleValueOf: ClassReg into: DPFPReg1.
	doOp := self Label.
	preOpCheckOrNil ifNotNil:
		[jumpFailCheck := self perform: preOpCheckOrNil with: DPFPReg0 with: DPFPReg1].
	self gen: arithmeticOperator operand: DPFPReg1 operand: DPFPReg0.
	jumpFailAlloc := objectRepresentation
					genAllocFloatValue: DPFPReg0
					into: SendNumArgsReg
					scratchReg: ClassReg
					scratchReg: TempReg.
	self MoveR: SendNumArgsReg R: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	self RetN: BytesPerWord * 2.
	jumpSmallInt jmpTarget: self Label.
	objectRepresentation genConvertSmallIntegerToIntegerInScratchReg: ClassReg.
	self ConvertR: ClassReg Rd: DPFPReg1.
	self Jump: doOp.
	jumpFailAlloc jmpTarget: self Label.
	self compileInterpreterPrimitive: (coInterpreter
										functionPointerForCompiledMethod: methodObj
										primitiveIndex: primitiveIndex).
	fail := self Label.
	jumpFailClass jmpTarget: self Label.
	preOpCheckOrNil ifNotNil:
		[jumpFailCheck jmpTarget: fail].
	^0