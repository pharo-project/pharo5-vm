ARM convenience instructions
fldd: destReg rn: srcReg plus: u imm: immediate8bitValue
"FLDD or VLDR instruction to move a value from address in an ARM srcReg +/- offset<<2 to an fpu double destReg
FLDD ARM_ARM v5 DDI 01001.pdf pp. C4-36
VLDR.64 ARM_ARM v7 DDI10406 pp. A8-622-3"
	<inline: true>
	"Note that
		offset is <<2 to make byte address 
		u =1 -> srcReg + offset<<2
		u=0 -> srgREg - offset<<2"
	^(((2r11101101000100000000101100000000 bitOr:(srcReg <<16)) bitOr: destReg<<12) bitOr: u<<23) bitOr: immediate8bitValue