instructions - control
jump: instruction
	| target |
	target := (pc + OneInstruction) bitAnd: 16rF0000000. "Region is that of the delay slot"
	target := target + (instruction target << 2).
	^'j ', (target printStringBase: 16)