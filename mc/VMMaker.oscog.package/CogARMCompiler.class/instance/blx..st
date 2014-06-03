ARM convenience instructions
blx: targetReg
"return a BX targetReg instruction"
	^self cond: AL bx: 1 target: targetReg
