instructions - arithmetic
andImmediate: instruction
	| rsValue immediate result |
	rsValue := self unsignedRegister: instruction rs.
	immediate := instruction unsignedImmediate.
	result := rsValue bitAnd: immediate.
	self unsignedRegister: instruction rt put: result.