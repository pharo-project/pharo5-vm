instructions - arithmetic
shiftLeftLogicalVariable: instruction
	| result rtValue shiftAmount |
	rtValue := self unsignedRegister: instruction rt.
	shiftAmount := self unsignedRegister: instruction rs.
	(31 allMask: shiftAmount) ifFalse: 
		["MIPS will use only the low 5 bits for this shift, but we probably
		  don't want to generate any code that hits this behavior."
		self error].
	result := (rtValue << shiftAmount) bitAnd: 16rFFFFFFFF.
	self unsignedRegister: instruction rd put: result.