instructions - control
branchEqual: instruction
	| offset target |
	offset := instruction signedImmediate << 2.
	target := pc + offset + OneInstruction. "Offset is relative to the delay slot"
	^'beq ', 
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(offset > 0 ifTrue: ['+'] ifFalse: ['']), offset printString, ' ; =', (target printStringBase: 16)