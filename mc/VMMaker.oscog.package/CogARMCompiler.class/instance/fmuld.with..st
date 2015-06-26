ARM convenience instructions
fmuld: destReg with: srcReg
"FMULD or VMUL instruction to multiply double srcReg by double destReg and stick result in double destReg
ARM_ARM v5 DDI 01001.pdf pp. C4-73"
	<inline: true>
	^((2r11101110001000000000101100000000 bitOr: destReg<<16 ) bitOr: destReg<<12) bitOr: srcReg