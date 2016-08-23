bytecode generators
duplicateTopBytecode
	self MoveMw: 0 r: SPReg R: TempReg.
	self PushR: TempReg.
	^0