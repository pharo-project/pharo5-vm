ARM convenience instructions
fsqrtd: destReg
"FSQRTD or VSQRT instruction to square root double dividend destReg and stick result in double destReg
ARM_ARM v5 DDI 01001.pdf pp. C4-97
VSQRT.F64 destReg, destReg - ARM_ARM v7 DDI10406 pp. A8-756-7"
	<inline: true>
	^((2r11101110101100010000101111000000 ) bitOr: destReg<<12) bitOr: destReg