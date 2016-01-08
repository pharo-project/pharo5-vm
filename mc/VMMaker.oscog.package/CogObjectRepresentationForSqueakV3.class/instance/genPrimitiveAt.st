primitive generators
genPrimitiveAt
	| jumpSI jumpNotSI jumpNotIndexable jumpIsContext jumpBounds jumpFmtGt4 jumpFmtEq2 jumpFmtLt8 jumpFmtGt11 jumpLarge |
	"c.f. StackInterpreter>>stSizeOf: lengthOf:baseHeader:format: fixedFieldsOf:format:length:"
	<var: #jumpSI type: #'AbstractInstruction *'>
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpNotIndexable type: #'AbstractInstruction *'>
	<var: #jumpIsContext type: #'AbstractInstruction *'>
	<var: #jumpBounds type: #'AbstractInstruction *'>
	<var: #jumpFmtGt4 type: #'AbstractInstruction *'>
	<var: #jumpFmtEq2 type: #'AbstractInstruction *'>
	<var: #jumpFmtLt8 type: #'AbstractInstruction *'>
	<var: #jumpFmtGt11 type: #'AbstractInstruction *'>
	<var: #jumpLarge type: #'AbstractInstruction *'>
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	jumpSI := self genJumpSmallInteger: ReceiverResultReg.
	cogit MoveR: Arg0Reg R: Arg1Reg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg.
	self
		genGetSizeOf: ReceiverResultReg
		into: ClassReg
		formatReg: SendNumArgsReg
		scratchReg: TempReg
		abortJumpsInto: [:jnx :jic| jumpNotIndexable := jnx. jumpIsContext := jic].
	self genConvertSmallIntegerToIntegerInReg: Arg1Reg.
	cogit SubCq: 1 R: Arg1Reg.
	cogit CmpR: ClassReg R: Arg1Reg.
	jumpBounds := cogit JumpAboveOrEqual: 0.
	"This is tedious.  Because of register pressure on x86 (and the baroque
	 complexity of the size computation) we have to recompute the format
	 because it may have been smashed computing the fixed fields.  But at
	 least we have the fixed fields, if any, in formatReg and recomputing
	 these is more expensive than recomputing format.  In any case this
	 should still be faster than the interpreter and we hope this object
	 representation's days are numbered."
	cogit
		MoveMw: 0 r: ReceiverResultReg R: ClassReg;	"self baseHeader: receiver"
		LogicalShiftRightCq: objectMemory instFormatFieldLSB R: ClassReg;
		AndCq: self instFormatFieldMask R: ClassReg;	"self formatOfHeader: ClassReg"
		CmpCq: 4 R: ClassReg.
	jumpFmtGt4 := cogit JumpGreater: 0.
	cogit CmpCq: 2 R: ClassReg.	"Common case, e.g. Array, has format = 2"
	jumpFmtEq2 := cogit JumpZero: 0.
	cogit AddR: SendNumArgsReg R: Arg1Reg. "Add fixed fields to index"
	jumpFmtEq2 jmpTarget: cogit Label.
	cogit "Too lazy [knackered, more like. ed.] to define index with displacement addressing right now"
		AddCq: objectMemory baseHeaderSize / objectMemory wordSize R: Arg1Reg;
		MoveXwr: Arg1Reg R: ReceiverResultReg R: ReceiverResultReg;
		genPrimReturn.
	jumpFmtGt4 jmpTarget: cogit Label.
	"Byte objects have formats 8 through 15, Compiled methods being 12 through 15;
	 fail for CompiledMethod allowing the CoInterpeter to impose stricter bounds checks."
	cogit CmpCq: 8 R: ClassReg.
	jumpFmtLt8 := cogit JumpLess: 0.
	cogit CmpCq: 11 R: ClassReg.
	jumpFmtGt11 := cogit JumpGreater: 0.
	cogit
		AddCq: objectMemory baseHeaderSize R: Arg1Reg;
		MoveXbr: Arg1Reg R: ReceiverResultReg R: ReceiverResultReg.
	self genConvertIntegerToSmallIntegerInReg: ReceiverResultReg.
	cogit genPrimReturn.
	jumpFmtLt8 jmpTarget: cogit Label.
	self assert: objectMemory wordSize = 4. "documenting my laziness"
	cogit "Too lazy [knackered, more like. ed.] to define index with displacement addressing right now"
		AddCq: objectMemory baseHeaderSize / objectMemory wordSize R: Arg1Reg;
		MoveXwr: Arg1Reg R: ReceiverResultReg R: ReceiverResultReg;
		CmpCq: 16r3FFFFFFF R: ReceiverResultReg.
	jumpLarge := cogit JumpAbove: 0.
	self genConvertIntegerToSmallIntegerInReg: ReceiverResultReg.
	cogit genPrimReturn.
	jumpLarge jmpTarget: (cogit CallRT: cePositive32BitIntegerTrampoline).
	cogit
		MoveR: TempReg R: ReceiverResultReg;
		genPrimReturn.
	jumpSI jmpTarget:
	(jumpNotSI jmpTarget:
	(jumpNotIndexable jmpTarget:
	(jumpIsContext jmpTarget:
	(jumpBounds jmpTarget:
	(jumpFmtGt11 jmpTarget:
		cogit Label))))).
	^0