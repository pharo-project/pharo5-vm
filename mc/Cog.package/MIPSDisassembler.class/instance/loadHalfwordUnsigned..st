instructions - memory
loadHalfwordUnsigned: instruction
	^'lhu ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(instruction signedImmediate printString), '(',
	(MIPSConstants nameForRegister: instruction rs), ')'