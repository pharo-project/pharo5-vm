instructions - arithmetic
bitwiseOr: instruction
	| rsValue rtValue result |
	rsValue := self signedRegister: instruction rs.
	rtValue := self signedRegister: instruction rt.
	result := rsValue bitOr: rtValue.
	self signedRegister: instruction rd put: result.