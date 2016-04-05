bytecode generators
genPushRemoteInstVarLongBytecode
	| index |
	index := byte1 + (extA << 8).
	extA := 0.
	self MoveMw: (self frameOffsetOfTemporary: byte2 - (1 << 7)) r: FPReg R: ClassReg.
	objectRepresentation 
		genEnsureOopInRegNotForwarded: ClassReg 
		scratchReg: TempReg.
	objectRepresentation
		genLoadSlot: index
		sourceReg: ClassReg
		destReg: TempReg.
	self PushR: TempReg.
	^0