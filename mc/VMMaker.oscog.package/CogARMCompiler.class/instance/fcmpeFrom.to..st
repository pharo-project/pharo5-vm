ARM convenience instructions
fcmpeFrom: regA to: regB
	"FCMPED or VCMPE instruction to compare two fpu double registers.
FCMPED regA, regB - ARM_ARM v5 DDI 01001.pdf pp. C4-12
VCMPE.F64 regA,regB - ARM_ARM v7 DDI10406 pp. 570-1"
	<inline: true>
	^(2r11101110101101000000101111000000 bitOr: (regA <<12)) bitOr: regB