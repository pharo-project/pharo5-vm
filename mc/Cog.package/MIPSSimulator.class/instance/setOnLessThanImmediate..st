instructions - arithmetic
setOnLessThanImmediate: instruction
	| rsValue immediate result |
	rsValue := self signedRegister: instruction rs.
	immediate := instruction signedImmediate.
	result := rsValue < immediate ifTrue: [1] ifFalse: [0].
	self signedRegister: instruction rt put: result.