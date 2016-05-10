ARM convenience instructions
fsitodFrom: regA to: regB
"FSITOD or VCVT instruction to move convert an integer value to an fpu double
FSITOD regB, regA - ARM_ARM v5 DDI 01001.pdf pp. C4-95
VCVTW. regB, regA - ARM_ARM v7 DDI10406.pdf pp. A8-576-8"
	<inline: true>
	|srcReg|
	"the src reg bits are spread out a little"
	srcReg := (regA >>1) bitOr:(regA bitAnd: 1) << 5.
	^(2r11101110101110000000101111000000 bitOr: srcReg ) bitOr: regB<<12