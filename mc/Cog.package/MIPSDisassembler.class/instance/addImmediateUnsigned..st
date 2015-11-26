instructions - arithmetic
addImmediateUnsigned: instruction
	^'addiu ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(instruction signedImmediate printString)