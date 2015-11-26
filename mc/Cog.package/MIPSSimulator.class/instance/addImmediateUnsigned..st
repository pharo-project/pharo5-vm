instructions - arithmetic
addImmediateUnsigned: instruction
	"Unsigned here means the instruction doesn't generate exceptions,
	 not that the immediate is unsigned."
	| rsValue immediate result |
	rsValue := self unsignedRegister: instruction rs.
	immediate := instruction signedImmediate.
	result := rsValue + immediate bitAnd: 16rFFFFFFFF. "No exception on overflow"
	self unsignedRegister: instruction rt put: result.