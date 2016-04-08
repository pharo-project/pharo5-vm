bytecode generator support
genPushRemoteInstVar: index inObjectAt: objectIndex
	self MoveMw: (self frameOffsetOfTemporary: objectIndex) r: FPReg R: ClassReg.
	objectRepresentation 
		genEnsureOopInRegNotForwarded: ClassReg 
		scratchReg: TempReg.
	objectRepresentation
		genLoadSlot: index
		sourceReg: ClassReg
		destReg: TempReg.
	self PushR: TempReg.
	^0