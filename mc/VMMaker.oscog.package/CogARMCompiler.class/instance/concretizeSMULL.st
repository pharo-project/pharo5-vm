generate machine code - concretize
concretizeSMULL
	| srcA srcB hiResultReg loResultReg |
	"Generate an SMULL loResultReg, hiResultReg, srcA, srcB instruction"
	srcA := self concreteRegister: (operands at: 0).
	"NOTE: srcB contains the other mutiplicand at this point. It is OK to use it as the destination for the low part of the result and in fact this saves us moving it later"
	loResultReg := srcB := self concreteRegister: (operands at: 1).
	hiResultReg := self concreteRegister: RISCTempReg.
	self machineCodeAt: 0
		put: (self type: 0 op: 6 set: 0 rn: hiResultReg rd: loResultReg)
			+ (srcA << 8)
			+ (9 << 4)
			+ srcB.
	^machineCodeSize := 4