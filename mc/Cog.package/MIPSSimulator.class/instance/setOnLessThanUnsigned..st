instructions - arithmetic
setOnLessThanUnsigned: instruction
	| rsValue rtValue result |
	rsValue := self unsignedRegister: instruction rs.
	rtValue := self unsignedRegister: instruction rt.
	result := rsValue < rtValue ifTrue: [1] ifFalse: [0].
	self signedRegister: instruction rd put: result.