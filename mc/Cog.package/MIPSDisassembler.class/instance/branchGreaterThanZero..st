instructions - control
branchGreaterThanZero: instruction
	| offset target |
	offset := instruction signedImmediate << 2.
	target := pc + offset + OneInstruction. "Offset is relative to the delay slot"
	^'bgtz ', 
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(offset > 0 ifTrue: ['+'] ifFalse: ['']), offset printString, ' ; =', (target printStringBase: 16)