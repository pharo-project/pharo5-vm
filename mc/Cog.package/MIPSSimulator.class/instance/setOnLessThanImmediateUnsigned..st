instructions - arithmetic
setOnLessThanImmediateUnsigned: instruction
	"The immediate is still sign-extended; it is the comparison that is unsigned."
	| rsValue immediate result |
	rsValue := self unsignedRegister: instruction rs.
	immediate := self signed32ToUnsigned32: instruction signedImmediate.
	result := rsValue < immediate ifTrue: [1] ifFalse: [0].
	self signedRegister: instruction rt put: result.