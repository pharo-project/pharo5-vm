ARM convenience instructions
fstd: fpReg rn: addrReg plus: u imm: immediate8bitValue
"FSTD or VSTR instruction to move a value to address in an ARM addrReg +/- offset<<2 from an fpu double fpReg
FSTD fpReg, addrReg, #offset - ARM_ARM v5 DDI 01001.pdf pp. C4-101
VSTR.64 fpReg, addrReg, #offset - ARM_ARM v7 DDI10406 pp. A8-780-1"
	<inline: true>
	"Note that
		offset is <<2 to make byte address 
		u =1 -> addrReg + offset<<2
		u=0 -> addrReg - offset<<2"
	^(((2r11101101000000000000101100000000 bitOr:(addrReg <<16)) bitOr: fpReg<<12) bitOr: u<<23) bitOr: immediate8bitValue