instructions - memory
storeWord: instruction
	^'sw ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(instruction signedImmediate printString), '(',
	(MIPSConstants nameForRegister: instruction rs), ')'