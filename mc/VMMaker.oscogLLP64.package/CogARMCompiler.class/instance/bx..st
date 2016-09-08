ARM convenience instructions
bx: targetReg
	"Branch to address in targetReg. BX targetReg
	BX targetReg  - ARM_ARM v7 DDI10406 pp. A8-62-3"
	<inline: true>
	^self cond: AL bx: 0 target: targetReg
