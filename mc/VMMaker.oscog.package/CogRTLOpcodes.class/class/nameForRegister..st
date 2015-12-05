debug printing
nameForRegister: reg "<Integer>"
	^#(Arg0Reg Arg1Reg ClassReg FPReg ReceiverResultReg SPReg SendNumArgsReg TempReg
		DPFPReg0 DPFPReg1 DPFPReg2 DPFPReg3 DPFPReg4 DPFPReg5 DPFPReg6 DPFPReg7
		LinkReg RISCTempReg VarBaseReg PCReg
		Scratch0Reg Scratch1Reg Scratch2Reg Scratch3Reg Scratch4Reg Scratch5Reg)
			detect: [:sym| (classPool at: sym) = reg]
			ifNone: ['REG', reg printString, '?']