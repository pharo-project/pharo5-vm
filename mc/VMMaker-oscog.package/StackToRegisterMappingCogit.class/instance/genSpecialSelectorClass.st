bytecode generators
genSpecialSelectorClass
	self ssPop: 1.
	self ssAllocateRequiredReg: SendNumArgsReg and: ClassReg.
	self ssPush: 1.
	self ssTop popToReg: SendNumArgsReg.
	objectRepresentation genGetClassObjectOf: SendNumArgsReg into: ClassReg scratchReg: TempReg.
	^self ssPop: 1; ssPushRegister: ClassReg