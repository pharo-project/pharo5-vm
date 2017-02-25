ARM convenience instructions
blx: targetReg
	"Branch&link to the address in targetReg. Return address is in LR
	BLX targetReg - ARM_ARM v7 DDI10406 pp. A8-60-1"
	<inline: true>
	^self cond: AL bx: 1 target: targetReg
