bytecode generators
genPushRemoteTempLongBytecode
	| newReg freeReg |
	newReg := self allocateRegNotConflictingWith: 0.
	freeReg := self availableRegNotConflictingWith: (self registerMaskFor: newReg).
	self MoveMw: (self frameOffsetOfTemporary: byte2) r: FPReg R: (freeReg ifNil: newReg).
	objectRepresentation
		genLoadSlot: byte1
		sourceReg: (freeReg ifNil: newReg)
		destReg: newReg.
	^self ssPushRegister: newReg