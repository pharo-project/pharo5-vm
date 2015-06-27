bytecode generators
genPushRemoteTempLongBytecode
	| newReg |
	newReg := self allocateRegNotConflictingWith: 0.
	self MoveMw: (self frameOffsetOfTemporary: byte2) r: FPReg R: newReg.
	objectRepresentation
		genLoadSlot: byte1
		sourceReg: newReg
		destReg: newReg.
	^self ssPushRegister: newReg