primitive generators
genPrimitiveObjectAt
	| headerReg jumpBadIndex jumpBounds jumpNotHeaderIndex |
	<var: #jumpBounds type: #'AbstractInstruction *'>
	<var: #jumpBadIndex type: #'AbstractInstruction *'>
	<var: #jumpNotHeaderIndex type: #'AbstractInstruction *'>
	cogit genLoadArgAtDepth: 0 into: Arg0Reg.
	jumpBadIndex := self genJumpNotSmallInteger: Arg0Reg scratchReg: TempReg.
	self genGetMethodHeaderOf: ReceiverResultReg into: (headerReg := Arg1Reg) scratch: TempReg.
	cogit CmpCq: (objectMemory integerObjectOf: 1) R: Arg0Reg.
	jumpNotHeaderIndex := cogit JumpNonZero: 0.
	cogit
		MoveR: headerReg R: ReceiverResultReg;
		genPrimReturn.
	jumpNotHeaderIndex jmpTarget: (cogit
		AndCq: (objectMemory integerObjectOf: coInterpreter alternateHeaderNumLiteralsMask) R: headerReg).
	cogit
		SubCq: (objectMemory integerObjectOf: 1) - objectMemory smallIntegerTag R: Arg0Reg;
		CmpR: headerReg R: Arg0Reg.
	jumpBounds := cogit JumpAbove: 0.

	self genConvertSmallIntegerToIntegerInReg: Arg0Reg.
	cogit
		AddCq: objectMemory baseHeaderSize >> objectMemory shiftForWord R: Arg0Reg;
		MoveXwr: Arg0Reg R: ReceiverResultReg R: ReceiverResultReg;
		genPrimReturn.

	jumpBounds jmpTarget: (cogit
		AddCq: (objectMemory integerObjectOf: 1) - objectMemory smallIntegerTag R: Arg0Reg).
	jumpBadIndex jmpTarget: cogit Label.
	^CompletePrimitive