debug printing
nameForRegister: reg "<Integer>"
	^#(Arg0Reg Arg1Reg ClassReg FPReg ReceiverResultReg SPReg SendNumArgsReg TempReg
		DPFPReg0 DPFPReg1 DPFPReg2 DPFPReg3 DPFPReg4 DPFPReg5 DPFPReg6 DPFPReg7 LinkReg)
			detect: [:sym| (classPool at: sym) = reg]