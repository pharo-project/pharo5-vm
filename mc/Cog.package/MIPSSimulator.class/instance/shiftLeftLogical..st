instructions - arithmetic
shiftLeftLogical: instruction
	| result rtValue shiftAmount |
	self assert: instruction rs = 0.
	rtValue := self unsignedRegister: instruction rt.
	shiftAmount := instruction sa.
	result := (rtValue << shiftAmount) bitAnd: 16rFFFFFFFF.
	self unsignedRegister: instruction rd put: result.