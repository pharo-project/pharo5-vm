bytecode generators
genSpecialSelectorClass
	self MoveMw: 0 r: SPReg R: SendNumArgsReg.
	objectRepresentation genGetClassObjectOf: SendNumArgsReg into: ClassReg scratchReg: TempReg.
	self MoveR: ClassReg Mw: 0 r: SPReg.
	^0