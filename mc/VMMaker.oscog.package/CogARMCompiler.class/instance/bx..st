ARM convenience instructions
bx: targetReg
"Branch to address in targetReg.
	BX targetReg"
	^self cond: AL bx: 0 target: targetReg
