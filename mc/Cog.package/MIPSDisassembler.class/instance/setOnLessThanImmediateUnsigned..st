instructions - arithmetic
setOnLessThanImmediateUnsigned: instruction
	"The immediate is still sign-extended; it is the comparison that is unsigned."
	^'sltiu ', 
	(MIPSConstants nameForRegister: instruction rt), ', ',
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(instruction signedImmediate printString) 