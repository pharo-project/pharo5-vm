instructions - arithmetic
shiftLeftLogicalVariable: instruction
	^'sllv ', 
	(MIPSConstants nameForRegister: instruction rd), ', ',
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(MIPSConstants nameForRegister: instruction rs)