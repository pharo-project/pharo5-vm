instructions - arithmetic
setOnLessThanImmediate: instruction
	^'slti ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(instruction signedImmediate printString)