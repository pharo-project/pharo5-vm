ARM convenience instructions
fmstat
	"FMSTAT or VMRS unconditional transfer FP status to cpsr to choose jumps etc.
FMSTAT r15, FPSCR - ARM_ARM v5 DDI 01001.pdf pp. C4-72
VMRS APSR_nzcv, FPSCR - ARM_ARM v7 DDI10406 pp. A8-652-3"
	<inline: true>
	^2r11101110111100011111101000010000