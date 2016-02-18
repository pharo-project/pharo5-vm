testing
instructionIsImmediateOffsetLoadStore: instr
	"is this any of the immediate offset LDR,STR instructions?"
	| op1 |
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	"test for 010 group of load/stores"
	op1 := instr >>25 bitAnd: 7.
	op1 = 2 ifTrue:[^true].

	"test for the ridiculously muddled 000 group"
	op1 > 0 ifTrue:[^false].
	"bit 21 must not be 1 and bit 22 must be 1"
	(instr bitAnd: 3 <<21) = (2<<21) ifFalse:[^false].
	"bits 4:7need to be 16rB for our purpose"
	^(instr bitAnd: 16rF0) = 16rB0
	
	