testing
instructionIsAnyLoadStore: instr
	"is this any of the LDR,STR instructions?
	We handle byte, word, and halfword versions but NOT NOT signed extend, double or privileged versions"
	
	^(self instructionIsImmediateOffsetLoadStore: instr) or:[self instructionIsRegisterOffsetLoadStore: instr]