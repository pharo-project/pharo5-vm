error handling
handleFailingFPArithmetic: instr at: pc
	
	"basic arithmetic"
	(instr bitAnd: 16rF400FB0) = 16rE000B00 ifTrue:
		[^self handleBasicDoubleArithmetic: instr at: pc].
	
	"extension instructions sqrt/cmp/sitod"
	(instr bitAnd: 16rFF00F70) = 16rEB00B40 ifTrue:
		[^self handleExtendedDoubleArithmetic: instr at: pc].
	
	"move ARM reg to coproc reg. "
	(instr bitAnd: 16rFF00FFF) = 16rE000A10 ifTrue:
		[^self handleRegToDoubleTransfer: instr at: pc].

	"move FPSCR reg to ARM CPSR"
	(instr bitAnd: 16rFFFFFFF) = 16rEF1FA10 ifTrue:
		[^self handleFPStatus: instr at: pc].

	"load and store ops. All doubles; we only use FLDD & FSTD"
	(instr bitAnd: 16rF600F00) = 16rD000B00 ifTrue:
		[^self handleFPLoadStore: instr at: pc].
	
	
	^self reportPrimitiveFailure