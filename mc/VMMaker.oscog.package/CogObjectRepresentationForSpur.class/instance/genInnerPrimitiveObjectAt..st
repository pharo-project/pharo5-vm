primitive generators
genInnerPrimitiveObjectAt: retNOffset
	| headerReg
	  jumpBadIndex jumpNotCogMethod jumpBounds jumpNotHeaderIndex |
	<var: #jumpBounds type: #'AbstractInstruction *'>
	<var: #jumpBadIndex type: #'AbstractInstruction *'>
	<var: #jumpNotCogMethod type: #'AbstractInstruction *'>
	<var: #jumpNotHeaderIndex type: #'AbstractInstruction *'>
	jumpBadIndex := self genJumpNotSmallInteger: Arg0Reg.
	"get header into Arg1Reg..."
	cogit MoveMw: objectMemory baseHeaderSize r: ReceiverResultReg R: (headerReg := Arg1Reg).
	jumpNotCogMethod := self genJumpSmallInteger: headerReg.
	cogit MoveMw: (cogit offset: CogMethod of: #methodHeader) r: headerReg R: headerReg.
	jumpNotCogMethod jmpTarget: (cogit
		CmpCq: (objectMemory integerObjectOf: 1) R: Arg0Reg).
	jumpNotHeaderIndex := cogit JumpNonZero: 0.
	cogit
		MoveR: headerReg R: ReceiverResultReg;
		RetN: retNOffset.
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
		RetN: retNOffset.

	jumpBounds jmpTarget: (cogit
		AddCq: (objectMemory integerObjectOf: 1) - objectMemory smallIntegerTag R: Arg0Reg).
	jumpBadIndex jmpTarget: cogit Label.
	^CompletePrimitive