instructions - memory
storeHalfword: instruction
	^'sh ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(instruction signedImmediate printString), '(',
	(MIPSConstants nameForRegister: instruction rs), ')'