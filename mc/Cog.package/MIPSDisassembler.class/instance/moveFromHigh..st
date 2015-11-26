instructions - arithmetic
moveFromHigh: instruction
	self assert: instruction rs = 0.
	self assert: instruction rt = 0.
	self assert: instruction sa = 0.
	^'mfhi ', (MIPSConstants nameForRegister: instruction rd)