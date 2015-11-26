instructions - arithmetic
shiftRightArithmetic: instruction
	^'sra ', 
	(MIPSConstants nameForRegister: instruction rd), ', ',
	(MIPSConstants nameForRegister: instruction rt), ', ',
	instruction sa printString