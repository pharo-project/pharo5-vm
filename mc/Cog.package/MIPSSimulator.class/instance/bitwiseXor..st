instructions - arithmetic
bitwiseXor: instruction
	| rsValue rtValue result |
	rsValue := self signedRegister: instruction rs.
	rtValue := self signedRegister: instruction rt.
	result := rsValue bitXor: rtValue.
	self signedRegister: instruction rd put: result.