instructions - arithmetic
andImmediate: instruction
	^'andi ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(instruction unsignedImmediate printString)