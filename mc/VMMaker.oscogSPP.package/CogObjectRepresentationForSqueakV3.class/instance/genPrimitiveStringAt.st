primitive generators
genPrimitiveStringAt
	| jumpNotSI jumpNotByteIndexable jumpBounds jumpShortHeader jumpSkip |
	"c.f. StackInterpreter>>stSizeOf: lengthOf:baseHeader:format: fixedFieldsOf:format:length:"
	<var: #jumpNotSI type: #'AbstractInstruction *'>
	<var: #jumpNotByteIndexable type: #'AbstractInstruction *'>
	<var: #jumpBounds type: #'AbstractInstruction *'>
	<var: #jumpShortHeader type: #'AbstractInstruction *'>
	<var: #jumpSkip type: #'AbstractInstruction *'>
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	cogit MoveR: Arg0Reg R: Arg1Reg.
	jumpNotSI := self genJumpNotSmallInteger: Arg0Reg.
	cogit
		MoveMw: 0 r: ReceiverResultReg R: TempReg;	"self baseHeader: receiver"
		MoveR: TempReg R: ClassReg;					"copy header word; we'll need it later"
		LogicalShiftRightCq: objectMemory instFormatFieldLSB R: TempReg;
		AndCq: self instFormatFieldMask R: TempReg;	"self formatOfHeader: destReg"
		MoveR: TempReg R: SendNumArgsReg;
		AndCq: 3 R: SendNumArgsReg;					"get odd bytes from format (if it turns out to be bytes)"
		SubR: SendNumArgsReg R: TempReg;
		CmpCq: 8 R: TempReg.							"check format is 8"
	jumpNotByteIndexable := cogit JumpNonZero: 0.
	cogit
		MoveR: ClassReg R: TempReg;
		AndCq: TypeMask R: TempReg;
		CmpCq: HeaderTypeSizeAndClass R: TempReg.	"(hdr bitAnd: TypeMask) = HeaderTypeSizeAndClass"
	jumpShortHeader := cogit JumpNonZero: 0.
	self assert: Size4Bit = 0.
	cogit
		MoveMw: 0 - (2 * objectMemory wordSize) r: ReceiverResultReg R: ClassReg; "(self sizeHeader: oop) bitAnd: LongSizeMask"
		AndCq: LongSizeMask signedIntFromLong R: ClassReg.
	jumpSkip :=  cogit Jump: 0.
	jumpShortHeader jmpTarget: (cogit AndCq: SizeMask R: ClassReg).	"hdr bitAnd: SizeMask"
	jumpSkip jmpTarget: (cogit SubCq: objectMemory baseHeaderSize R: ClassReg). "sz - BaseHeaderSize"
	cogit SubR: SendNumArgsReg R: ClassReg. "sz - (fmt bitAnd: 3)"
	self genConvertSmallIntegerToIntegerInReg: Arg1Reg.
	cogit SubCq: 1 R: Arg1Reg.
	cogit CmpR: ClassReg R: Arg1Reg.
	jumpBounds := cogit JumpAboveOrEqual: 0.
	cogit AddCq: objectMemory baseHeaderSize R: Arg1Reg.
	cogit genMoveConstant: objectMemory characterTable R: Arg0Reg.
	cogit MoveXbr: Arg1Reg R: ReceiverResultReg R: ReceiverResultReg;
		AddCq: objectMemory baseHeaderSize / objectMemory wordSize R: ReceiverResultReg.
	cogit MoveXwr: ReceiverResultReg R: Arg0Reg R: ReceiverResultReg.
	cogit genPrimReturn.
	jumpNotSI jmpTarget:
	(jumpNotByteIndexable jmpTarget:
	(jumpBounds jmpTarget:
		cogit Label)).
	^0