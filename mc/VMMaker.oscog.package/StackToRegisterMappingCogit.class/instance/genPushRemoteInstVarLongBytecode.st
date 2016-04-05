bytecode generators
genPushRemoteInstVarLongBytecode
	| tempVectReg remoteTempReg |	
	tempVectReg := self allocateRegNotConflictingWith: 0.
	self MoveMw: (self frameOffsetOfTemporary: byte2 - (1 << 7)) r: FPReg R: tempVectReg.
	objectRepresentation 
		genEnsureOopInRegNotForwarded: tempVectReg 
		scratchReg: TempReg.
	remoteTempReg := self availableRegOrNoneNotConflictingWith: (self registerMaskFor: tempVectReg). 
	remoteTempReg = NoReg ifTrue: [remoteTempReg := tempVectReg].
	objectRepresentation
		genLoadSlot: byte1
		sourceReg: tempVectReg
		destReg: remoteTempReg.
	^self ssPushRegister: remoteTempReg