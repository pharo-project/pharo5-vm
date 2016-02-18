instructions - arithmetic
shiftRightLogical: instruction
	^'srl ', 
	(MIPSConstants nameForRegister: instruction rd), ', ',
	(MIPSConstants nameForRegister: instruction rt), ', ',
	instruction sa printString