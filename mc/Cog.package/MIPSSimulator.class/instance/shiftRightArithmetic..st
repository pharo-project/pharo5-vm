instructions - arithmetic
shiftRightArithmetic: instruction
	| result rtValue shiftAmount |
	self assert: instruction rs = 0.
	rtValue := self signedRegister: instruction rt.
	shiftAmount := instruction sa.
	result := rtValue >> shiftAmount.
	self signedRegister: instruction rd put: result.