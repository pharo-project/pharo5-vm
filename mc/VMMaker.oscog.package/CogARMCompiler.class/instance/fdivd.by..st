ARM convenience instructions
fdivd: dividend by: divisor
"FDIVD or VDIV instruction to divide double dividend by double divisor and stick result in double dividend
FDIVD dividend, dividend, divisor - ARM_ARM v5 DDI 01001.pdf pp. C4-32
VDIV.F64 dvidend, dividend, divisor - ARM_ARM v7 DDI10406 pp. A8-584-5"
	<inline: true>
	^((2r11101110100000000000101100000000 bitOr: dividend<<16 ) bitOr: dividend<<12) bitOr: divisor