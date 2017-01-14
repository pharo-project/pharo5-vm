primitive generators
genPrimitiveSize
	| jumpSI jumpNotIndexable jumpIsContext |
	"c.f. StackInterpreter>>stSizeOf: lengthOf:baseHeader:format: fixedFieldsOf:format:length:"
	<var: #jumpSI type: #'AbstractInstruction *'>
	<var: #jumpIsContext type: #'AbstractInstruction *'>
	<var: #jumpNotIndexable type: #'AbstractInstruction *'>
	jumpSI := self genJumpSmallInteger: ReceiverResultReg.
	self
		genGetSizeOf: ReceiverResultReg
		into: ClassReg
		formatReg: SendNumArgsReg
		scratchReg: TempReg
		abortJumpsInto: [:jnx :jic| jumpNotIndexable := jnx. jumpIsContext := jic].
	self genConvertIntegerToSmallIntegerInReg: ClassReg.
	cogit MoveR: ClassReg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpSI jmpTarget: (jumpNotIndexable jmpTarget: (jumpIsContext jmpTarget: cogit Label)).
	^0