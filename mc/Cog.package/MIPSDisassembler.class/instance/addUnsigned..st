instructions - arithmetic
addUnsigned: instruction
	^'addu ', 
	(MIPSConstants nameForRegister: instruction rd), ', ',
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(MIPSConstants nameForRegister: instruction rt)