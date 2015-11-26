instructions - arithmetic
bitwiseAnd: instruction
	| rsValue rtValue result |
	rsValue := self signedRegister: instruction rs.
	rtValue := self signedRegister: instruction rt.
	result := rsValue bitAnd: rtValue.
	self signedRegister: instruction rd put: result.