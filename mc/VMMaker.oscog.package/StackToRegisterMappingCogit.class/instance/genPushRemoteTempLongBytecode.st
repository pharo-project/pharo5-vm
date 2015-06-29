bytecode generators
genPushRemoteTempLongBytecode
	| tempVectReg remoteTempReg |
	tempVectReg := self allocateRegNotConflictingWith: 0.
	self MoveMw: (self frameOffsetOfTemporary: byte2) r: FPReg R: tempVectReg.
	remoteTempReg := (self availableRegOrNilNotConflictingWith: (self registerMaskFor: tempVectReg)) ifNil: [ tempVectReg ].
	objectRepresentation
		genLoadSlot: byte1
		sourceReg: tempVectReg
		destReg: remoteTempReg.
	^self ssPushRegister: remoteTempReg