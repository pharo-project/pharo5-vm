generate machine code - concretize
concretizeSMULL
	| srcReg destReg hiReg loReg |
	srcReg := self concreteRegister: (operands at: 0).
	destReg := self concreteRegister: (operands at: 1).
	hiReg := self concreteRegister: RISCTempReg.
	loReg := self concreteRegister: TempReg.
	self machineCodeAt: 0
		put: (self type: 0 op: 6 set: 0 rn: hiReg rd: loReg)
			+ (srcReg << 8)
			+ (9 << 4)
			+ destReg.
	^machineCodeSize := 4