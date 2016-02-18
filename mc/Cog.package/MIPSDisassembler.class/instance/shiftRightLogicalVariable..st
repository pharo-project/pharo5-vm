instructions - arithmetic
shiftRightLogicalVariable: instruction
	^'srlv ', 
	(MIPSConstants nameForRegister: instruction rd), ', ',
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(MIPSConstants nameForRegister: instruction rs)