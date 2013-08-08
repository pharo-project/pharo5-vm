primitive generators
genInnerPrimitiveSize: retNoffset
	| jumpNotSI jumpNotIndexable jumpIsContext |
	"c.f. StackInterpreter>>stSizeOf: lengthOf:baseHeader:format: fixedFieldsOf:format:length:"
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpNotIndexable type: #'AbstractInstruction *'>
	<var: #jumpIsContext type: #'AbstractInstruction *'>
	cogit MoveR: ReceiverResultReg R: TempReg.
	jumpNotSI := self genJumpSmallIntegerInScratchReg: TempReg.
	self
		genGetSizeOf: ReceiverResultReg
		into: ClassReg
		formatReg: SendNumArgsReg
		scratchReg: TempReg
		abortJumpsInto: [:jnx :jic| jumpNotIndexable := jnx. jumpIsContext := jic].
	self genConvertIntegerToSmallIntegerInScratchReg: ClassReg.
	cogit MoveR: ClassReg R: ReceiverResultReg.
	self flag: 'currently caller pushes result'.
	cogit RetN: retNoffset.
	jumpNotSI jmpTarget: (jumpNotIndexable jmpTarget: (jumpIsContext jmpTarget: cogit Label)).
	^0