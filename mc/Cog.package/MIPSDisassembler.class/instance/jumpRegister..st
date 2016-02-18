instructions - control
jumpRegister: instruction
	^'jr ', (MIPSConstants nameForRegister: instruction rs)