primitive generators
genGetSizeOf: sourceReg into: destReg formatReg: formatReg scratchReg: scratchReg abortJumpsInto: aBinaryBlock
	"Get the size of the non-immediate object in sourceReg into destReg using formatReg
	 and scratchReg as temps.  None of these registers can overlap.  Supply the jumps
	 taken if the object in sourceReg is not indexable, or if the object in sourceReg is a
	 context.. Hack: If the object has a pointer format other than 2 leave the number of
	 fixed fields in formatReg.  Used by primitiveSize, primitiveAt, and primitiveAtPut"
	<returnTypeC: #'AbstractInstruction *'>
	| jumpNotIndexable jumpIsContext jumpShortHeader jumpSkip
	  jumpFmtLeWeakArray jumpFmtIsArray jmpFmtGeFirstByte jumpGotByteSize jumpGotWordSize |
	<inline: true>
	"c.f. StackInterpreter>>stSizeOf: lengthOf:baseHeader:format: fixedFieldsOf:format:length:"
	"and one wonders why Squeak V1 through V3 are slow..."
	<var: #jumpNotIndexable type: #'AbstractInstruction *'>
	<var: #jumpIsContext type: #'AbstractInstruction *'>
	<var: #jumpShortHeader type: #'AbstractInstruction *'>
	<var: #jumpSkip type: #'AbstractInstruction *'>
	<var: #jumpFmtLeWeakArray type: #'AbstractInstruction *'>
	<var: #jumpFmtIsArray type: #'AbstractInstruction *'>
	<var: #jmpFmtGeFirstByte type: #'AbstractInstruction *'>
	<var: #jumpGotByteSize type: #'AbstractInstruction *'>
	<var: #jumpGotWordSize type: #'AbstractInstruction *'>
	cogit
		MoveMw: 0 r: sourceReg R: formatReg;				"destReg := self baseHeader: receiver"
		MoveR: formatReg R: destReg;
		LogicalShiftRightCq: objectMemory instFormatFieldLSB R: formatReg;
		AndCq: self instFormatFieldMask R: formatReg;		"formatReg := self formatOfHeader: destReg"
		CmpCq: objectMemory arrayFormat R: formatReg.
	jumpNotIndexable := cogit JumpLess: 0.
	cogit
		MoveR: destReg R: scratchReg;
		LogicalShiftRightCq: objectMemory compactClassFieldLSB R: scratchReg;
		AndCq: self compactClassFieldMask R: scratchReg;	"scratchReg := self compactClassIndexOfHeader: destReg"
		CmpCq: ClassMethodContextCompactIndex R: scratchReg.
	jumpIsContext := cogit JumpZero: 0.
	cogit
		MoveR: destReg R: scratchReg;
		AndCq: TypeMask R: scratchReg;
		CmpCq: HeaderTypeSizeAndClass R: scratchReg.	"(hdr bitAnd: TypeMask) = HeaderTypeSizeAndClass"
	jumpShortHeader := cogit JumpNonZero: 0.
	self assert: Size4Bit = 0.
	cogit
		MoveMw: 0 - (2 * objectMemory wordSize) r: sourceReg R: destReg; "(self sizeHeader: oop) bitAnd: LongSizeMask"
		AndCq: LongSizeMask signedIntFromLong R: destReg.
	jumpSkip :=  cogit Jump: 0.
	jumpShortHeader jmpTarget: (cogit AndCq: SizeMask R: destReg).	"hdr bitAnd: SizeMask"
	jumpSkip jmpTarget: (cogit SubCq: objectMemory baseHeaderSize R: destReg). "sz - BaseheaderSize for all three arms"
	cogit CmpCq: objectMemory weakArrayFormat R: formatReg.	"fmt <= 4"
	jumpFmtLeWeakArray := cogit JumpLessOrEqual: 0.
	cogit CmpCq: objectMemory firstByteFormat R: formatReg.
	jmpFmtGeFirstByte := cogit JumpLess: 0.
	cogit
		AndCq: 3 R: formatReg;	"(sz - BaseHeaderSize) - (fmt bitAnd: 3) bytes"
		SubR: formatReg R: destReg.
	jumpGotByteSize := cogit Jump: 0.
	jmpFmtGeFirstByte jmpTarget: (cogit LogicalShiftRightCq: 2 R: destReg). "(sz - BaseHeaderSize) >> 2 32-bit longs"
	jumpGotWordSize := cogit Jump: 0.
	jumpFmtLeWeakArray jmpTarget: cogit Label.
	cogit
		LogicalShiftRightCq: objectMemory shiftForWord R: destReg; "(sz - BaseHeaderSize) >> ShiftForWord words"
		CmpCq: objectMemory arrayFormat R: formatReg.
	jumpFmtIsArray := cogit JumpZero: 0.
	self genGetFixedFieldsOfPointerNonInt: sourceReg into: formatReg scratchReg: scratchReg.
	cogit SubR: formatReg R: destReg.
	jumpFmtIsArray jmpTarget:
	(jumpGotWordSize jmpTarget:
	(jumpGotByteSize jmpTarget:
		cogit Label)).
	aBinaryBlock value: jumpNotIndexable value: jumpIsContext