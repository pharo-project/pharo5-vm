instructions - control
jumpAndLinkRegister: instruction
	instruction rd = 31 ifTrue: [^'jalr ', (MIPSConstants nameForRegister: instruction rs)].
	^'jalr ',
	(MIPSConstants nameForRegister: instruction rd), ', ',
	(MIPSConstants nameForRegister: instruction rs)