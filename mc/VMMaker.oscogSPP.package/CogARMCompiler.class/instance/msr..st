encoding
msr: flags
"Generate an MSR CPSR_f, #flags instruction.
Note that 
a) CPSR_f is equivalent to APSR_nzcvq (ARM ARM DDI0406A p A8-209 & A2-14)
b) We only have business with the NZCV flags so the generated instruction shifts the flags value <<28 - which is a ROR 4"

	^16r1328F000
	+ (2 "rotate rights are in units of 2, remember" << 8)
	+ (flags bitAnd: 16rF) " to make sure we don't have silly values here"