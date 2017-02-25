bytecode generator support
genJumpBackTo: targetBytecodePC
	self MoveAw: coInterpreter stackLimitAddress R: TempReg.
	self CmpR: TempReg R: SPReg. "N.B. FLAGS := SPReg - TempReg"
	self JumpAboveOrEqual: (self fixupAt: targetBytecodePC).
	self CallRT: ceCheckForInterruptTrampoline.
	self annotateBytecode: self Label.
	self Jump: (self fixupAt: targetBytecodePC).
	^0