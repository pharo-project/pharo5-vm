bytecode generators
genJumpBackTo: targetBytecodePC
	self MoveAw: coInterpreter stackLimitAddress R: TempReg.
	self CmpR: TempReg R: SPReg. "N.B. FLAGS := SPReg - TempReg"
	self JumpAboveOrEqual: (self fixupAt: targetBytecodePC - initialPC).
	self annotateBytecode: (self CallRT: ceCheckForInterruptTrampoline).
	self Jump: (self fixupAt: targetBytecodePC - initialPC).
	^0