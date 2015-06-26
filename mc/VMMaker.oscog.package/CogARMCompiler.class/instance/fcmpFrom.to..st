ARM convenience instructions
fcmpFrom: regA to: regB
"FCMP or VCMP instruction to compare two fpu double registers.
ARM_ARM v5 DDI 01001.pdf pp. C4-10"
	<inline: true>
	^(2r11101110101101000000101101000000 bitOr:(regA <<12)) bitOr: regB