instructions - arithmetic
subtractUnsigned: instruction
	"Unsigned here means the instruction doesn't generate exceptions."
	| rsValue rtValue result |
	rsValue := self unsignedRegister: instruction rs.
	rtValue := self unsignedRegister: instruction rt.
	result := rsValue - rtValue bitAnd: 16rFFFFFFFF. "No exception on overflow"
	self unsignedRegister: instruction rd put: result.