instructions - arithmetic
bitwiseAnd: instruction
	^'and ', 
	(MIPSConstants nameForRegister: instruction rd), ', ',
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(MIPSConstants nameForRegister: instruction rt)