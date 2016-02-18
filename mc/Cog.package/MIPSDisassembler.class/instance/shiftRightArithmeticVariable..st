instructions - arithmetic
shiftRightArithmeticVariable: instruction
	^'srav ', 
	(MIPSConstants nameForRegister: instruction rd), ', ',
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(MIPSConstants nameForRegister: instruction rs)