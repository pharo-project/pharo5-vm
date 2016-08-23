ARM convenience instructions
fmsrFrom: regA to: regB
"FMSR or VMOV instruction to move a value from an ARM reg to an fpu double register ready for conversion
FMSR regB, regA - ARM_ARM v5 DDI 01001.pdf pp. C4-68
VMOV regB, regA - ARM_ARM v7 DDi10406 pp. A8-462-3"
	<inline: true>
	|destReg|
	"the dest reg bits are spread out a little"
	destReg := (regB >>1) <<16 bitOr:(regB bitAnd: 1) << 7.
	^(2r11101110000000000000101000010000 bitOr:(regA <<12)) bitOr: destReg