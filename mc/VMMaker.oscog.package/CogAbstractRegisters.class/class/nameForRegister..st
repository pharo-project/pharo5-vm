debug printing
nameForRegister: reg "<Integer>"
	^#(Arg0Reg Arg1Reg ClassReg FPReg ReceiverResultReg SPReg SendNumArgsReg TempReg
		LinkReg RISCTempReg VarBaseReg PCReg
		Scratch0Reg Scratch1Reg Scratch2Reg Scratch3Reg Scratch4Reg Scratch5Reg)
			detect: [:sym| (classPool at: sym) = reg]
			ifNone: ['REG', reg printString, '?']