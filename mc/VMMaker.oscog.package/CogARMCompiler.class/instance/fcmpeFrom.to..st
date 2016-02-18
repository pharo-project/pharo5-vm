ARM convenience instructions
fcmpeFrom: regA to: regB
	"FCMPE or VCMPE instruction to compare two fpu double registers.
	 ARM_ARM v5 DDI 01001.pdf pp. C4-12"
	<inline: true>
	^(2r11101110101101000000101111000000 bitOr: (regA <<12)) bitOr: regB