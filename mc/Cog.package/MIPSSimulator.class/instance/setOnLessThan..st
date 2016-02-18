instructions - arithmetic
setOnLessThan: instruction
	| rsValue rtValue result |
	rsValue := self signedRegister: instruction rs.
	rtValue := self signedRegister: instruction rt.
	result := rsValue < rtValue ifTrue: [1] ifFalse: [0].
	self signedRegister: instruction rd put: result.