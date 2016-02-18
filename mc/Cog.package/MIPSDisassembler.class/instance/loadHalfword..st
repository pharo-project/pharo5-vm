instructions - memory
loadHalfword: instruction
	^'lh ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(instruction signedImmediate printString), '(',
	(MIPSConstants nameForRegister: instruction rs), ')'