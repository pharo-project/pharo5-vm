ARM convenience instructions
fmsrFrom: regA to: regB
"FMSR or VMSR instruction to move a value from an ARM reg to an fpu double register ready for conversion
ARM_ARM v5 DDI 01001.pdf pp. C4-68"
	<inline: true>
	|destReg|
	"the dest reg bits are spread out a little"
	destReg := (regB >>1) <<16 bitOr:(regB bitAnd: 1) << 7.
	^(2r11101110000000000000101000010000 bitOr:(regA <<12)) bitOr: destReg