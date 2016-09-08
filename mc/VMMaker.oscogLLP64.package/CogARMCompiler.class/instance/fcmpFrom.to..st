ARM convenience instructions
fcmpFrom: regA to: regB
"FCMPD or VCMP instruction to compare two fpu double registers.
FCMPD regA, regB - ARM_ARM v5 DDI 01001.pdf pp. C4-10
VCMP.F64 regA, regB - ARM_ARM v7 DDI10406 -1"
	<inline: true>
	^(2r11101110101101000000101101000000 bitOr:(regA <<12)) bitOr: regB