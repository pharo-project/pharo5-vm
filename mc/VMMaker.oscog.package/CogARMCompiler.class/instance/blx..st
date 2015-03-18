ARM convenience instructions
blx: targetReg
"Branch&link to the address in targetReg. Return address is in LR
	BX targetReg"
	^self cond: AL bx: 1 target: targetReg
