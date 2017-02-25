generate machine code - concretize
concretizeCMPSMULL
	"Generate a CMP a, b, ASR #31 instruction, specifically for comparing the resutls of SMULLs in genMulR:R:"
	| hiReg loReg |
	hiReg := operands at: 0.
	loReg := operands at: 1.
	self machineCodeAt: 0
		put: (self type: 0 op: CmpOpcode set: 1 rn: hiReg rd: 0)
			+ (31<<7) "the shift amount"
			+ (2<<5) "the shift type - ASR"
			+ loReg.
	^machineCodeSize := 4