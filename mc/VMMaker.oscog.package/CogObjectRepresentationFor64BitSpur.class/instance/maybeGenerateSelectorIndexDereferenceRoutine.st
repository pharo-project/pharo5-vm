initialization
maybeGenerateSelectorIndexDereferenceRoutine
	"Generate the routine that converts selector indices into selector objects.
	 It is called from the send trampolines.
	 If the selector index is negative, convert it into a positive index into the
	 special selectors array and index that.  Otherwise, index the current method."
	| jumpNegative jumpNotBlock |
	<var: 'jumpNegative' type: #'AbstractInstruction *'>
	<var: 'jumpNotBlock' type: #'AbstractInstruction *'>
	cogit zeroOpcodeIndex.
	cogit CmpCq: 0 R: ClassReg.
	jumpNegative := cogit JumpLess: 0.
	cogit
		MoveMw: FoxMethod r: FPReg R: Scratch0Reg;
		AddCq: 2 R: ClassReg; "Change selector index to 1-relative, skipping the method header"
		TstCq: MFMethodFlagIsBlockFlag R: Scratch0Reg.
	jumpNotBlock := cogit JumpZero: 0.
	cogit "If in a block, need to find the home method..."
		AndCq: methodZone alignment negated R: Scratch0Reg;
		MoveM16: 0 r: Scratch0Reg R: Scratch1Reg;
		SubR: Scratch1Reg R: Scratch0Reg.
	jumpNotBlock jmpTarget: cogit Label.
	cogit "Now fetch the method object and index with the literal index to retrieve the selector"
		AndCq: methodZone alignment negated R: Scratch0Reg;
		MoveMw: (cogit offset: CogMethod of: #methodObject) r: Scratch0Reg R: Scratch1Reg;
		MoveXwr: ClassReg R: Scratch1Reg R: ClassReg;
		RetN: 0.
	jumpNegative jmpTarget: cogit Label.
	cogit
		NegateR: ClassReg;
		LogicalShiftLeftCq: 1 R: ClassReg;
		MoveAw: objectMemory specialObjectsArrayAddress R: Scratch0Reg;
		SubCq: 1 R: ClassReg;
		MoveMw: SpecialSelectors + 1 * objectMemory wordSize r: Scratch0Reg R: Scratch1Reg; "Index, including header size"
		MoveXwr: ClassReg R: Scratch1Reg R: ClassReg;
		RetN: 0.
	ceDereferenceSelectorIndex := cogit methodZoneBase.
	cogit
		outputInstructionsForGeneratedRuntimeAt: ceDereferenceSelectorIndex;
		recordGeneratedRunTime: 'ceDereferenceSelectorIndex' address: ceDereferenceSelectorIndex;
		recordRunTimeObjectReferences