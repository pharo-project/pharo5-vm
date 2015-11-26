instructions - arithmetic
shiftRightLogical: instruction
	| result rtValue shiftAmount |
	self assert: instruction rs = 0.
	rtValue := self unsignedRegister: instruction rt.
	shiftAmount := instruction sa.
	result := rtValue >> shiftAmount.
	self unsignedRegister: instruction rd put: result.