instructions - memory
storeByte: instruction
	^'sb ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(instruction signedImmediate printString), '(',
	(MIPSConstants nameForRegister: instruction rs), ')'