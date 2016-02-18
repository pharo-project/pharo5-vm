instructions - control
jumpAndLink: instruction
	| target |
	target := (pc + OneInstruction) bitAnd: 16rF0000000. "Region is that of the delay slot"
	target := target + (instruction target << 2).
	^'jal ', (target printStringBase: 16)