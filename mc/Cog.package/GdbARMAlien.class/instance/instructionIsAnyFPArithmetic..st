testing
instructionIsAnyFPArithmetic: instr
	"Identify VFP instructions.
	 See C3.1 - C3.4 in the ARM ARM v5 DDI01001."
	| cp isFP |
	
	"All FP instructions are coprocessor instructions on coproc 10 or 11"
	cp := instr>>8 bitAnd: 16rF.
	isFP := cp = 10 or:[cp = 11].
	(isFP and: [(instr>>25 bitAnd: 7) = 6]) ifTrue: [^true].
	(isFP and: [(instr>>24 bitAnd: 16rF) = 16rE]) ifTrue: [^true].
	
	"nope"
	^false