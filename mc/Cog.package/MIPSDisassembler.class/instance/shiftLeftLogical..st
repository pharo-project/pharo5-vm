instructions - arithmetic
shiftLeftLogical: instruction
	instruction value = 0 ifTrue: [^'nop'].
	^'sll ', 
	(MIPSConstants nameForRegister: instruction rd), ', ',
	(MIPSConstants nameForRegister: instruction rt), ', ',
	instruction sa printString