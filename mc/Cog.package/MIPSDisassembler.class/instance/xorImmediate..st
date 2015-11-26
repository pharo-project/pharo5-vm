instructions - arithmetic
xorImmediate: instruction
	^'xori ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(instruction unsignedImmediate printString)