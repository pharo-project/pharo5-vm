instructions - arithmetic
divideSigned: instruction
	self assert: instruction rd = 0.
	self assert: instruction sa = 0.
	^'div ', 
	(MIPSConstants nameForRegister: instruction rs), ', ',
	(MIPSConstants nameForRegister: instruction rt)