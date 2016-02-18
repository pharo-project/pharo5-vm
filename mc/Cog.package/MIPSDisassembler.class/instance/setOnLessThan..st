instructions - arithmetic
setOnLessThan: instruction
	^'slt ', 
	(MIPSConstants nameForRegister: instruction rd), ', ',
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(MIPSConstants nameForRegister: instruction rt)