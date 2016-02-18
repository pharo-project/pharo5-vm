instructions - arithmetic
orImmediate: instruction
	| rsValue immediate result |
	rsValue := self unsignedRegister: instruction rs.
	immediate := instruction unsignedImmediate.
	result := rsValue bitOr: immediate.
	self unsignedRegister: instruction rt put: result.