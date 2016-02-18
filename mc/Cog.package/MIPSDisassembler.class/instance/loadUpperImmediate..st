instructions - arithmetic
loadUpperImmediate: instruction
	^'lui ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(instruction signedImmediate printString)