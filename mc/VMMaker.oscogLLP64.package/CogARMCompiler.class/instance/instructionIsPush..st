testing
instructionIsPush: instr
	"is this a push -str r??, [sp, #-4] -  instruction?"
	^(self conditionIsNotNever: instr) and: [(instr bitAnd: 16rFFF0FFF) = 16r52D0004]