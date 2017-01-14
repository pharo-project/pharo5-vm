encoding - memory
prefR: baseReg offset: offset hint: hint
	self flag: #todo. "Should we generate a nop instead? gcc gives an error trying to assemble this for mips1 (1985), mips2 (1990) and mips3 (1992), but succeeds with mips4 (1994) and mips32 (1999)."
	self assert: (hint == HintLoad or: [hint == HintStore]).
	^self itype: PREF rs: baseReg rt: hint signedImmediate: offset