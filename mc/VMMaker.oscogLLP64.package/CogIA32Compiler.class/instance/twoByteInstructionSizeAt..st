disassembly
twoByteInstructionSizeAt: pc
	| op |
	op := objectMemory byteAt: pc + 1. 
	^(op bitAnd: 16rF0) caseOf:
		{	[16r80]	->	[6 "long conditional jumps"] }