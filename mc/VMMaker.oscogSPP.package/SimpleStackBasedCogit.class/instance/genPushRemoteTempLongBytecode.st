bytecode generators
genPushRemoteTempLongBytecode
	self MoveMw: (self frameOffsetOfTemporary: byte2) r: FPReg R: ClassReg.
	objectRepresentation
		genLoadSlot: byte1
		sourceReg: ClassReg
		destReg: TempReg.
	self PushR: TempReg.
	^0