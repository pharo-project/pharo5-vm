instructions - control
branchLessThanZero: instruction
	| offset target |
	offset := instruction signedImmediate << 2.
	target := pc + offset + OneInstruction. "Offset is relative to the delay slot"
	^'bltz ', 
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(offset > 0 ifTrue: ['+'] ifFalse: ['']), offset printString, ' ; =', (target printStringBase: 16)