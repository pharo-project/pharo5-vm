instructions - arithmetic
moveFromLow: instruction
	self assert: instruction rs = 0.
	self assert: instruction rt = 0.
	self assert: instruction sa = 0.
	^'mflo ', (MIPSConstants nameForRegister: instruction rd)