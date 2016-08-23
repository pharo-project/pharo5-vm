ARM convenience instructions
faddd: destReg with: srcReg
"FADDD or VADD instruction to add double srcReg to double destReg and stick result in double destReg
FADDD destReg, destReg, srcReg -  ARM_ARM v5 DDI 01001.pdf pp. C4-6
VADD.F64 destReg, destReg, srcReg - ARM_ARM v7 DDI10406.pdf pp. A8-536-7"
	<inline: true>
	^((2r11101110001100000000101100000000 bitOr: destReg<<16 ) bitOr: destReg<<12) bitOr: srcReg