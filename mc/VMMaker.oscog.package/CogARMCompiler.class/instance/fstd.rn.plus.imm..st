ARM convenience instructions
fstd: destReg rn: srcReg plus: u imm: immediate8bitValue
"FSTD or VSTR instruction to move a value to address in an ARM srcReg +/- offset<<2 from an fpu double destReg
ARM_ARM v5 DDI 01001.pdf pp. C4-101"
	<inline: true>
	"Note that
		offset is <<2 to make byte address 
		u =1 -> srcReg + offset<<2
		u=0 -> srgREg - offset<<2"
	^(((2r11101101000000000000101100000000 bitOr:(srcReg <<16)) bitOr: destReg<<12) bitOr: u<<23) bitOr: immediate8bitValue