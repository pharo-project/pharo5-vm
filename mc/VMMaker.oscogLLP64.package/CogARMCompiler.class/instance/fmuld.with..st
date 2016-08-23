ARM convenience instructions
fmuld: destReg with: srcReg
"FMULD or VMUL instruction to multiply double srcReg by double destReg and stick result in double destReg
FMULD destReg, destReg, srcReg - ARM_ARM v5 DDI 01001.pdf pp. C4-73
VMUL.F64 destReg, destReg, srcReg - ARM_ARM v7 DDI10406 pp A8-658-9"
	<inline: true>
	^((2r11101110001000000000101100000000 bitOr: destReg<<16 ) bitOr: destReg<<12) bitOr: srcReg