instructions - arithmetic
orImmediate: instruction
	^'ori ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(instruction unsignedImmediate printString)