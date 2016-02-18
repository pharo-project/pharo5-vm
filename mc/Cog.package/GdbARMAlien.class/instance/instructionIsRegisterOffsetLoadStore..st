testing
instructionIsRegisterOffsetLoadStore: instr
	"is this any of the register offset LDR,STR instructions?"
	| op1 |
	"first test for non-NV condition code; some important instructions use it"
	instr >> 28 = 16rF ifTrue:[^false].
	
	op1 := instr >>25 bitAnd: 7.
	"test for the 011 group - check bit 4 as well"
	(op1 = 3 and:[(instr bitAnd: 16r10) = 0]) ifTrue:[^true].
	"test for the ridiculously muddled 000 group"
	op1 > 0 ifTrue:[^false].
	"bit 21 & 22 must not be 1"
	(instr bitAnd: 3 <<21) = 0 ifFalse:[^false].
	"bits 4:7need to be 16rB for our purpose"
	^(instr bitAnd: 16rF0) = 16rB0
	
	