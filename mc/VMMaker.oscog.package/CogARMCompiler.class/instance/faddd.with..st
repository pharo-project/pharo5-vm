ARM convenience instructions
faddd: destReg with: srcReg
"FADDD or VADD instruction to add double srcReg to double destReg and stick result in double destReg
ARM_ARM v5 DDI 01001.pdf pp. C4-6"
	<inline: true>
	^((2r11101110001100000000101100000000 bitOr: destReg<<16 ) bitOr: destReg<<12) bitOr: srcReg