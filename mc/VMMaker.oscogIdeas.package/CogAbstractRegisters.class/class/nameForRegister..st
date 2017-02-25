debug printing
nameForRegister: reg "<Integer>"
	^#(Arg0Reg Arg1Reg ClassReg FPReg ReceiverResultReg SPReg SendNumArgsReg TempReg
		LinkReg RISCTempReg VarBaseReg PCReg
		Extra0Reg Extra1Reg Extra2Reg Extra3Reg Extra4Reg Extra5Reg)
			detect: [:sym| (classPool at: sym) = reg]
			ifNone: ['REG', reg printString, '?']