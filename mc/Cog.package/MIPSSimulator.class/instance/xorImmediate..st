instructions - arithmetic
xorImmediate: instruction
	| rsValue immediate result |
	rsValue := self unsignedRegister: instruction rs.
	immediate := instruction unsignedImmediate.
	result := rsValue bitXor: immediate.
	self unsignedRegister: instruction rt put: result.