primitive generators
genInnerPrimitiveSize: retNoffset
	| jumpSI jumpNotIndexable jumpIsContext |
	"c.f. StackInterpreter>>stSizeOf: lengthOf:baseHeader:format: fixedFieldsOf:format:length:"
	<var: #jumpSI type: #'AbstractInstruction *'>
	<var: #jumpNotIndexable type: #'AbstractInstruction *'>
	<var: #jumpIsContext type: #'AbstractInstruction *'>
	cogit MoveR: ReceiverResultReg R: TempReg.
	jumpSI := self genJumpSmallIntegerInScratchReg: TempReg.
	self
		genGetSizeOf: ReceiverResultReg
		into: ClassReg
		formatReg: SendNumArgsReg
		scratchReg: TempReg
		abortJumpsInto: [:jnx :jic| jumpNotIndexable := jnx. jumpIsContext := jic].
	self genConvertIntegerToSmallIntegerInReg: ClassReg.
	cogit MoveR: ClassReg R: ReceiverResultReg.
	cogit RetN: retNoffset.
	jumpSI jmpTarget: (jumpNotIndexable jmpTarget: (jumpIsContext jmpTarget: cogit Label)).
	^0