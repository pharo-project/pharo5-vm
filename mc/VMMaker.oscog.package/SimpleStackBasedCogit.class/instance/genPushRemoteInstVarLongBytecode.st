bytecode generators
genPushRemoteInstVarLongBytecode
	self MoveMw: (self frameOffsetOfTemporary: byte2 - (1 << 7)) r: FPReg R: ClassReg.
	objectRepresentation 
		genEnsureOopInRegNotForwarded: ClassReg 
		scratchReg: TempReg.
	objectRepresentation
		genLoadSlot: byte1
		sourceReg: ClassReg
		destReg: TempReg.
	self PushR: TempReg.
	^0