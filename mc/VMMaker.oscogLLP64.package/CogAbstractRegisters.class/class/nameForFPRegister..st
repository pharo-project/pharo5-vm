debug printing
nameForFPRegister: reg "<Integer>"
	^#(DPFPReg0 DPFPReg1 DPFPReg2 DPFPReg3 DPFPReg4 DPFPReg5 DPFPReg6 DPFPReg7
		DPFPReg8 DPFPReg9 DPFPReg10 DPFPReg11 DPFPReg12 DPFPReg13 DPFPReg14 DPFPReg15)
		detect: [:sym| (classPool at: sym) = reg]
		ifNone: ['REG', reg printString, '?']