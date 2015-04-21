ARM convenience instructions
bx: targetReg
	"Branch to address in targetReg. BX targetReg"
	<inline: true>
	^self cond: AL bx: 0 target: targetReg
