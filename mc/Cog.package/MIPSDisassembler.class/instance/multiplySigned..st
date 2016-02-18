instructions - arithmetic
multiplySigned: instruction
	self assert: instruction rd = 0.
	self assert: instruction sa = 0.
	^'mult ', 
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(MIPSConstants nameForRegister: instruction rt)