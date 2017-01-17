initialization
maybeGenerateSelectorIndexDereferenceRoutine
	"Generate the routine that converts selector indices into selector objects.
	 It is called from the send trampolines.
	 If the selector index is negative, convert it into a positive index into the
	 special selectors array and index that.  Otherwise, index the current method.
	 The routine uses Extra0Reg & Extra1Reg, which are available, since they
	 are not live at point of send."
	| jumpNegative jumpNotBlock jumpFullBlock |
	<var: 'jumpNegative' type: #'AbstractInstruction *'>
	<var: 'jumpNotBlock' type: #'AbstractInstruction *'>
	<var: 'jumpFullBlock' type: #'AbstractInstruction *'>
	cogit zeroOpcodeIndex.
	cogit CmpCq: 0 R: ClassReg.
	jumpNegative := cogit JumpLess: 0.
	cogit
		MoveMw: FoxMethod r: FPReg R: Extra0Reg;
		AddCq: 2 R: ClassReg; "Change selector index to 1-relative, skipping the method header"
		TstCq: MFMethodFlagIsBlockFlag R: Extra0Reg.
	jumpNotBlock := cogit JumpZero: 0.
	"If in a block, need to find the home method...  If using full blocks, need to test the cpicHasMNUCaseOrCMIsFullBlock bit"
	cogit AndCq: methodZone alignment negated R: Extra0Reg.
	SistaV1BytecodeSet ifTrue:
		[self bitAndByteOffsetOfIsFullBlockBitInto:
			[:bitmask :byteOffset|
			jumpFullBlock := cogit
				MoveMb: byteOffset r: Extra0Reg R: Extra1Reg;
				TstCq: bitmask R: Extra1Reg;
				JumpNonZero: 0]].
	cogit 
		MoveM16: 0 r: Extra0Reg R: Extra1Reg;
		SubR: Extra1Reg R: Extra0Reg.
	jumpNotBlock jmpTarget: cogit Label.
	SistaV1BytecodeSet ifTrue:
		[jumpFullBlock jmpTarget: jumpNotBlock getJmpTarget].
	cogit "Now fetch the method object and index with the literal index to retrieve the selector"
		AndCq: methodZone alignment negated R: Extra0Reg;
		MoveMw: (cogit offset: CogMethod of: #methodObject) r: Extra0Reg R: Extra1Reg;
		MoveXwr: ClassReg R: Extra1Reg R: ClassReg;
		RetN: 0.
	jumpNegative jmpTarget: cogit Label.
	cogit
		NegateR: ClassReg;
		LogicalShiftLeftCq: 1 R: ClassReg;
		MoveAw: objectMemory specialObjectsArrayAddress R: Extra0Reg;
		SubCq: 1 R: ClassReg;
		MoveMw: SpecialSelectors + 1 * objectMemory wordSize r: Extra0Reg R: Extra1Reg; "Index, including header size"
		MoveXwr: ClassReg R: Extra1Reg R: ClassReg;
		RetN: 0.
	ceDereferenceSelectorIndex := cogit methodZoneBase.
	cogit
		outputInstructionsForGeneratedRuntimeAt: ceDereferenceSelectorIndex;
		recordGeneratedRunTime: 'ceDereferenceSelectorIndex' address: ceDereferenceSelectorIndex;
		recordRunTimeObjectReferences