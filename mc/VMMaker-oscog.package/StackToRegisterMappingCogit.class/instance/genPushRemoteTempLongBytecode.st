bytecode generators
genPushRemoteTempLongBytecode
	self ssAllocateRequiredReg: ClassReg and: SendNumArgsReg.
	self MoveMw: (self frameOffsetOfTemporary: byte2) r: FPReg R: ClassReg.
	objectRepresentation
		genLoadSlot: byte1
		sourceReg: ClassReg
		destReg: SendNumArgsReg.
	^self ssPushRegister: SendNumArgsReg